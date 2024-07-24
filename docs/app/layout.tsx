import "./global.css";
import { RootProvider } from "fumadocs-ui/provider";
import { Inter as FontSans } from "next/font/google";
import type { ReactNode } from "react";
import { cn } from "@/lib/utils";

const fontSans = FontSans({
    subsets: ["latin"],
    variable: "--font-sans",
});

export default function Layout({ children }: { children: ReactNode }) {
    return (
        <html lang="en" suppressHydrationWarning>
            <body
                className={cn(
                    "min-h-screen bg-background font-sans antialiased",
                    fontSans.variable
                )}
            >
                {/* Search needs a server route, which a static export doesn't have. */}
                <RootProvider search={{ enabled: false }}>{children}</RootProvider>
            </body>
        </html>
    );
}
