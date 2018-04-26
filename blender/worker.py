import bpy
import os
import time
import netrender
from netrender.utils import *
bpy.data.scenes["Scene"].render.engine = "NET_RENDER"
bpy.data.scenes["Scene"].network_render.mode = "RENDER_SLAVE"
bpy.data.scenes["Scene"].network_render.server_address = "manager"
bpy.data.scenes["Scene"].network_render.server_port = 8000

bpy.ops.render.netclientstart()
