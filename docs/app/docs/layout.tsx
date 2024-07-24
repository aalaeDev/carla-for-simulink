import { DocsLayout } from "fumadocs-ui/layout";
import type { ReactNode } from "react";
import { docsOptions } from "../layout.config";

export default function Layout({ children }: { children: ReactNode }) {
    return (
        <DocsLayout {...docsOptions} sidebar={{ defaultOpenLevel: 0 }}>
            {children}
        </DocsLayout>
    );
}
