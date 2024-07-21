def getReadings(sensor):
    sensor.listen(lambda sensor_data: IMU_callback(sensor_data))

def IMU_callback(sensor_data):
    global data
    data = sensor_data
    