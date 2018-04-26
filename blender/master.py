import bpy
import os
import time
import netrender
from netrender.utils import *
bpy.data.scenes["Scene"].render.engine = "NET_RENDER"
bpy.data.scenes["Scene"].network_render.mode = "RENDER_MASTER"

bpy.ops.render.netclientstart()
