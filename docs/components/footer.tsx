import { siteConfig } from "@/config/site";
import Link from "next/link";

export default function Footer() {
    return (
        <footer>
            <p className="text-balance text-center text-sm leading-loose text-muted-foreground pb-2">
                Built by{" "}
                <Link
                    href={siteConfig.links.twitter}
                    className="font-medium underline underline-offset-4"
                >
                    xaeon7
                </Link>
                . The source code is available on{" "}
                <Link
                    href={siteConfig.links.github}
                    className="font-medium underline underline-offset-4"
                >
                    Github
                </Link>
                .
            </p>
        </footer>
    );
}
