import type { MDXComponents } from "mdx/types";
import defaultComponents from "fumadocs-ui/mdx";
import { Callout } from "@ui/callout";
import SimulinkBlock from "@ui/simulink-block";
import GridContainer from "@components/grid-container";
import TypeTable from "@components/types-table";
import PageLink from "@ui/page-link";
import ParameterAccordion from "@components/parameter_accordion";
import { LibraryBlocks } from "@components/library-blocks";
import { Icons } from "@components/icons";
import Link from "next/link";
import Image from "next/image";
import { Step, Steps } from "fumadocs-ui/components/steps";

export function useMDXComponents(components: MDXComponents): MDXComponents {
    return {
        ...defaultComponents,
        ...components,
        Callout,
        SimulinkBlock,
        GridContainer,
        PageLink,
        TypeTable,
        LibraryBlocks,
        Link,
        Icons,
        Image,
        ParameterAccordion,
        Step,
        Steps,
    };
}
