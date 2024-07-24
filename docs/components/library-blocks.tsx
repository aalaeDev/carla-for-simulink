import Image from "next/image";
import SimulinkBlock from "./ui/simulink-block";
import carlaLogo from "public/carla-logo.png";
import worldTick from "public/world-clock.png";

export const LibraryBlocks = {
    LaunchCarla: () => (
        <SimulinkBlock
            name="Launch Carla"
            icon={
                <Image
                    alt="carla-logo"
                    src={carlaLogo.src}
                    width={256}
                    height={256}
                    className="dark:invert"
                />
            }
            className="bg-slate-400 bg-opacity-20 backdrop-blur-sm"
        />
    ),
    WorldTick: () => (
        <SimulinkBlock
            name="World Tick"
            icon={
                <Image
                    alt="world-tick"
                    src={worldTick.src}
                    width={256}
                    height={256}
                    className="dark:invert"
                />
            }
            className="bg-slate-400 bg-opacity-20 backdrop-blur-sm"
        />
    ),
    GetAcceleration: () => (
        <SimulinkBlock
            name="GetAcceleration"
            icon="Get Acceleration"
            inputs={["ActorID"]}
            outputs={["AccX", "AccY", "AccZ"]}
            className="bg-orange-700 bg-opacity-20 backdrop-blur-sm"
        />
    ),
    GetAngularVelocity: () => (
        <SimulinkBlock
            name="GetAngularVelocity"
            icon="Get Angular Velocity"
            inputs={["ActorID"]}
            outputs={["PitchRate", "YawRate", "RollRate"]}
            className="bg-orange-700 bg-opacity-20 backdrop-blur-sm"
        />
    ),
    GetLocation: () => (
        <SimulinkBlock
            name="GetLocation"
            icon="Get Location"
            inputs={["ActorID"]}
            outputs={["PosX", "PosY", "PosZ"]}
            className="bg-orange-700 bg-opacity-20 backdrop-blur-sm"
        />
    ),
    GetTransform: () => (
        <SimulinkBlock
            name="GetTransform"
            icon="Get Transform"
            inputs={["ActorID"]}
            outputs={["PosX", "PosY", "PosZ", "PitchAng", "YawAng", "RollAng"]}
            className="bg-orange-700 bg-opacity-20 backdrop-blur-sm"
        />
    ),
    GetVelocity: () => (
        <SimulinkBlock
            name="GetVelocity"
            icon="Get Velocity"
            inputs={["ActorID"]}
            outputs={["SpdX", "SpdY", "SpdZ"]}
            className="bg-orange-700 bg-opacity-20 backdrop-blur-sm"
        />
    ),
    ApplyControl: () => (
        <SimulinkBlock
            name="ApplyControl"
            icon="Apply Control"
            inputs={[
                "VehicleID",
                "Throttle",
                "Brake",
                "SteerAng",
                "HandBrake",
                "isRevGear",
            ]}
            className="bg-sky-700 bg-opacity-20 backdrop-blur-sm"
        />
    ),
    SetAutopilot: () => (
        <SimulinkBlock
            name="SetAutopilot"
            icon="Set Autopilot"
            inputs={["VehicleID", "Status"]}
            className="bg-sky-700 bg-opacity-20 backdrop-blur-sm"
        />
    ),
    SetLocation: () => (
        <SimulinkBlock
            name="SetLocation"
            icon="Set Location"
            inputs={["VehicleID", "PosX", "PosY", "PosZ"]}
            className="bg-sky-700 bg-opacity-20 backdrop-blur-sm"
        />
    ),
    SetTargetAngularVelocity: () => (
        <SimulinkBlock
            name="SetTargetAngularVelocity"
            icon="Set Target Angular Velocity"
            inputs={["VehicleID", "PitchRate", "YawRate", "RollRate"]}
            className="bg-sky-700 bg-opacity-20 backdrop-blur-sm"
        />
    ),
    SetTargetVelocity: () => (
        <SimulinkBlock
            name="SetTargetVelocity"
            icon="Set Target Velocity"
            inputs={["VehicleID", "SpdX", "SpdY", "SpdZ"]}
            className="bg-sky-700 bg-opacity-20 backdrop-blur-sm"
        />
    ),
    SetTransform: () => (
        <SimulinkBlock
            name="SetTransform"
            icon="Set Transform"
            inputs={[
                "VehicleID",
                "PosX",
                "PosY",
                "PosZ",
                "Pitch",
                "Yaw",
                "Roll",
            ]}
            className="bg-sky-700 bg-opacity-20 backdrop-blur-sm"
        />
    ),
    GNSS: () => (
        <SimulinkBlock
            name="GNSS Sensor"
            icon="GNSS"
            inputs={["ActorID"]}
            outputs={["Altitude", "Latitude", "Longitude"]}
            className="bg-pink-700 bg-opacity-20 backdrop-blur-sm"
        />
    ),
    IMU: () => (
        <SimulinkBlock
            name="IMU Sensor"
            icon="IMU"
            inputs={["ActorID"]}
            outputs={[
                "AccX",
                "AccY",
                "AccZ",
                "YawRate",
                "PitchRate",
                "RollRate",
                "Compass",
            ]}
            className="bg-pink-700 bg-opacity-20 backdrop-blur-sm"
        />
    ),
    LIDAR: () => (
        <SimulinkBlock
            name="LIDAR Sensor"
            icon="LIDAR"
            inputs={["ActorID"]}
            outputs={["Channels", "HorizAng", "RawData"]}
            className="bg-pink-700 bg-opacity-20 backdrop-blur-sm"
        />
    ),
    RADAR: () => (
        <SimulinkBlock
            name="RADAR Sensor"
            icon="RADAR"
            inputs={["ActorID"]}
            outputs={["RawData"]}
            className="bg-pink-700 bg-opacity-20 backdrop-blur-sm"
        />
    ),
};
