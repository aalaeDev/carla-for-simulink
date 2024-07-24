import Link from "next/link";

import { SquareArrowOutUpRightIcon } from "lucide-react";

interface PageLinkProps {
    url: string;
    text: string;
}

export default function PageLink({ url, text }: PageLinkProps) {
    return (
        <Link
            target="_blank"
            href={url}
            className="flex items-center bg-muted gap-1 w-fit text-xs px-2 rounded-md no-underline font-medium -mt-4 mb-8"
        >
            {text} <SquareArrowOutUpRightIcon className="w-3" />
        </Link>
    );
}
