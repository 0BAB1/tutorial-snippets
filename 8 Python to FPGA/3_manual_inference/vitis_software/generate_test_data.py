# This generates an header file with N MNIST flatten sample
# data is 8bits INT8 (or just char) meant to be imported
# into a Tx buffer for use in Vitis (for DMA).
# we can then use labels to compare execution

import torch
from torchvision import datasets, transforms
import random

def quantize_tensor(x, num_bits=8):
    qmin = 0.
    qmax = 2.**num_bits - 1.
    min_val, max_val = x.min(), x.max()

    scale = (max_val - min_val) / (qmax - qmin)
    initial_zero_point = qmin - min_val / scale

    zero_point = 0
    if initial_zero_point < qmin:
        zero_point = qmin
    elif initial_zero_point > qmax:
        zero_point = qmax
    else:
        zero_point = initial_zero_point

    zero_point = int(zero_point)
    q_x = zero_point + x / scale
    q_x.clamp_(qmin, qmax).round_()
    
    return q_x.byte()

# Load MNIST dataset
transform = transforms.Compose([
    transforms.ToTensor(),
    transforms.Lambda(lambda x: quantize_tensor(x))
])

mnist_dataset = datasets.FashionMNIST(root='./data', train=True, download=True, transform=transform)

print(mnist_dataset[0][0])

# Select random samples
num_samples = 100
indices = random.sample(range(num_samples), num_samples)
print(indices)
samples = [mnist_dataset[i][0] for i in indices]
labels = [mnist_dataset[i][1] for i in indices]
print(labels)

# Generate C header file
with open('mnist_samples.h', 'w') as f:
    f.write("// This file has been auto-generated\n\n")
    f.write("#ifndef MNIST_SAMPLES_H\n")
    f.write("#define MNIST_SAMPLES_H\n\n")
    f.write(f"#define NUM_SAMPLES {str(num_samples)}\n")
    f.write("#define IMAGE_SIZE 784\n\n")
    
    f.write("const unsigned char mnist_samples[NUM_SAMPLES][IMAGE_SIZE] = {\n")
    
    for i, sample in enumerate(samples):
        # Denormalize, scale to 0-255, and flatten
        img = sample.squeeze()
        img_flat = img.reshape(-1).byte().tolist()
        
        f.write("    {")
        f.write(", ".join(map(str, img_flat)))
        f.write("},\n")
    
    f.write("};\n\n")

    f.write("const unsigned char mnist_labels[NUM_SAMPLES] = {\n")

    for j, label in enumerate(labels):
        f.write("    " + str(label) + ",\n")
    
    f.write("};\n\n")
    f.write("#endif // MNIST_SAMPLES_H\n")

print("MNIST samples have been generated and saved in 'mnist_samples.h'")