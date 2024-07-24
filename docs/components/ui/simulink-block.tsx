import { cn } from "@/lib/utils";

interface SimulinkBlockProps {
    name: string;
    icon?: string | React.ReactNode;
    inputs?: string[];
    outputs?: string[];
    className?: string;
}

export default function SimulinkBlock({
    name,
    icon,
    inputs,
    outputs,
    className,
}: SimulinkBlockProps) {
    const portNames = [...(inputs || [""]), ...(outputs || [""])];

    const longestPortName = portNames.reduce((longest, current) => {
        return current.length > longest.length ? current : longest;
    }, "");
    const portLabelsWidth = longestPortName.length * 8;

    function renderPorts(ports: string[] | undefined, isInput: boolean) {
        return (
            <div
                className={`flex h-full flex-col text-left ${
                    isInput ? "-mr-0.5" : "-ml-0.5"
                }`}
            >
                {ports?.map((port, index) => (
                    <div
                        key={index}
                        id={`${name.replace(" ", "-")}-${
                            isInput ? "in" : "out"
                        }-${port}`}
                        className="text-muted-foreground h-6 flex items-center"
                    >
                        {">"}
                    </div>
                ))}
            </div>
        );
    }

    function renderPortLabels(ports: string[] | undefined, isInput: boolean) {
        return ports ? (
            <div
                className={`flex flex-col text-left text-xs`}
                style={{ width: `${portLabelsWidth}px` }}
            >
                {ports.map((port, index) => (
                    <div
                        key={index}
                        className={`text-muted-foreground h-6 flex items-center ${
                            isInput ? "self-start" : "self-end"
                        }`}
                    >
                        {port}
                    </div>
                ))}
            </div>
        ) : (
            <div style={{ width: `${portLabelsWidth}px` }}></div>
        );
    }

    return (
        <div className="flex flex-col items-center justify-center w-fit">
            <div className="flex items-center">
                {renderPorts(inputs, true)}

                <div
                    className={cn(
                        "border border-muted-foreground rounded py-4 px-1 flex justify-center items-center gap-4",
                        className
                    )}
                >
                    {renderPortLabels(inputs, true)}
                    {icon ? (
                        <div
                            className={`flex text-center items-center h-12 ${
                                typeof icon === "string" ? "" : "w-12"
                            }`}
                        >
                            {icon}
                        </div>
                    ) : (
                        <div className="w-12 h-4" />
                    )}
                    {renderPortLabels(outputs, false)}
                </div>

                {renderPorts(outputs, false)}
            </div>

            <div className="flex">
                {inputs?.length && <div className="w-2"></div>}
                <div className="text-sm mt-1 text-muted-foreground">{name}</div>
                {outputs?.length && <div className="w-2"></div>}
            </div>
        </div>
    );
}
