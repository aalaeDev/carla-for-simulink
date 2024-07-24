import * as React from "react";
import { cva, type VariantProps } from "class-variance-authority";

import { cn } from "@/lib/utils";

import { Callout as FumaCallout } from "fumadocs-ui/components/callout";
import { XCircle, AlertCircle, Info, X } from "lucide-react";

const calloutVariants = cva("bg-opacity-20", {
    variants: {
        variant: {
            info: "bg-blue-600 border-blue-600",
            warn: "bg-yellow-600 border-yellow-600",
            error: "bg-red-600 border-red-600",
        },
    },
    defaultVariants: {
        variant: "info",
    },
});

export interface CalloutProps
    extends Omit<
            React.HTMLAttributes<HTMLDivElement>,
            "title" | "type" | "icon"
        >,
        VariantProps<typeof calloutVariants> {
    asChild?: boolean;
    title?: React.ReactNode;
    type?: "info" | "warn" | "error" | undefined;
    icon?: React.ReactNode;
}

function Callout({
    className,
    title,
    type,
    icon,
    asChild = false,
    ...props
}: CalloutProps) {
    const variant = type;
    const customIcon = icon ? (
        icon
    ) : type === "error" ? (
        <XCircle className="text-red-600" />
    ) : type === "warn" ? (
        <AlertCircle className="text-yellow-600" />
    ) : (
        <Info className="text-blue-600" />
    );
    return (
        <FumaCallout
            className={cn(calloutVariants({ variant, className }))}
            title={title}
            type={type}
            icon={customIcon}
            {...props}
        ></FumaCallout>
    );
}

export { Callout, calloutVariants };
