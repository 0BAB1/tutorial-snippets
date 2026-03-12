# that's the file that grabs UART raw text from the MSPM0 pcb
# parses it, and makes some nice vector visual with it.
#
# BRH 2026

import pyqtgraph as pg
import pyqtgraph.opengl as gl
from pyqtgraph.Qt import QtWidgets, QtCore
import serial


ser = serial.Serial('/dev/ttyUSB1')

app = QtWidgets.QApplication([])

w = gl.GLViewWidget()
w.show()
w.setWindowTitle('Live 3D Vector')
w.setCameraPosition(distance=3000)

# Axes
axis = gl.GLAxisItem()
axis.setSize(1000,1000,1000)
w.addItem(axis)
vec_line = gl.GLLinePlotItem(pos=[[0,0,0],[0,0,0]], color=(1,0,0,1), width=3)
w.addItem(vec_line)

def update_vector():
    s = str(ser.read(115))
    x_found = y_found = z_found = 0
    x = y = z = 0
    for i, char in enumerate(s):
        if char == "X" and s[i+1] != "_" and not x_found:
            x = s[i+2:i+7]
            x = int(x.strip(": mg'"))
            x_found = 1
        if char == "Y" and s[i+1] != "_" and not y_found:
            y = s[i+2:i+7]
            y = int(y.strip(": mg'"))
            y_found = 1
        if char == "Z" and s[i+1] != "_" and not z_found:
            z = s[i+2:i+7]
            z = int(z.strip(": mg'"))
            z_found = 1
    vec_line.setData(pos=[[0,0,0],[-x,-y,-z]])

timer = QtCore.QTimer()
timer.timeout.connect(update_vector)
timer.start(100)

QtWidgets.QApplication.instance().exec_()