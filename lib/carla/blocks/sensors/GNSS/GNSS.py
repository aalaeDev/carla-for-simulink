def getReadings(sensor):
    sensor.listen(lambda sensor_data: GNSS_callback(sensor_data))

def GNSS_callback(sensor_data):
    global data
    data = sensor_data
    