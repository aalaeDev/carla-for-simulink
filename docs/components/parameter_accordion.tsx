import {
    Accordion,
    AccordionContent,
    AccordionItem,
    AccordionTrigger,
} from "@components/ui/accordion";

interface ParameterAccordionProps {
    title: string | React.ReactNode;
    description: string | React.ReactNode;
    subtitle?: string | React.ReactNode;
    types?: string | React.ReactNode;
}

export default function ParameterAccordion({
    title,
    description,
    subtitle,
    types,
}: ParameterAccordionProps) {
    return (
        <Accordion type="single" collapsible>
            <AccordionItem value="title">
                <AccordionTrigger className="p-4">
                    <div className="flex flex-col items-start">
                        <div className="flex items-center gap-2">
                            <span>{title}</span>
                            {subtitle ? (
                                <>
                                    <span className="text-muted-foreground text-sm">
                                        —
                                    </span>
                                    <span className="text-muted-foreground text-sm">
                                        {subtitle}
                                    </span>
                                </>
                            ) : null}
                        </div>
                        {subtitle ? (
                            <div className="text-muted-foreground text-xs">
                                {types}
                            </div>
                        ) : null}
                    </div>
                </AccordionTrigger>
                <AccordionContent className="p-4">
                    {description}
                </AccordionContent>
            </AccordionItem>
        </Accordion>
    );
}
