import { type DocsLayoutProps } from "fumadocs-ui/layout";
import { type HomeLayoutProps } from "fumadocs-ui/home-layout";
import { pageTree } from "@/app/source";
import { siteConfig } from "@/config/site";

// shared configuration
export const baseOptions: HomeLayoutProps = {
    nav: {
        title: siteConfig.name,
    },
    links: [
        {
            text: "Documentation",
            url: "/docs",
            active: "nested-url",
        },
    ],
};

// docs layout configuration
export const docsOptions: DocsLayoutProps = {
    ...baseOptions,
    tree: pageTree,
    githubUrl: siteConfig.links.github,
};
