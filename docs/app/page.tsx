import { siteConfig } from "@/config/site";
import Footer from "@components/footer";
import { Icons } from "@components/icons";
import { Badge } from "@components/ui/badge";
import { Button } from "@components/ui/button";
import Link from "next/link";

export default function HomePage() {
    return (
        <main className="flex h-screen flex-col justify-center text-center p-4">
            <div className="absolute inset-0 -z-10">
                <Icons.grid_background className="w-full h-full" />
            </div>

            <div className="flex flex-col-reverse md:flex-row items-center md:items-start justify-center gap-2">
                <h1 className="text-6xl font-bold">{siteConfig.name}</h1>{" "}
                <Badge className="w-fit h-fit">{siteConfig.version}</Badge>
            </div>

            <p className="text-muted-foreground mb-6 mt-4">
                {siteConfig.description}
            </p>

            <div>
                <Link href="/docs">
                    <Button>Get Started</Button>
                </Link>
            </div>

            <div className="absolute bottom-0 -translate-x-1/2 left-1/2 flex flex-col items-center justify-between gap-4">
                <Footer />
            </div>
        </main>
    );
}
