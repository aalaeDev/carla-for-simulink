import {
    Table,
    TableBody,
    TableCell,
    TableHead,
    TableHeader,
    TableRow,
} from "@/components/ui/table";

interface row {
    port: string;
    type?: string;
    dimension?: string;
    default?: string;
}

interface TypesTableProps {
    rows: row[];
    isInput?: true;
}

export default function TypesTable({ rows, isInput }: TypesTableProps) {
    return (
        <Table>
            <TableHeader>
                <TableRow>
                    <TableHead>Port</TableHead>
                    <TableHead>Type</TableHead>
                    <TableHead>Dimension</TableHead>
                    {isInput ? <TableHead>Default</TableHead> : null}
                </TableRow>
            </TableHeader>
            <TableBody>
                {rows.map((row, idx) => (
                    <TableRow key={idx}>
                        <TableCell>
                            <code className="rounded-md p-1 bg-primary/10 text-primary">
                                {row.port}
                            </code>
                        </TableCell>
                        <TableCell>
                            <code className="rounded-md bg-secondary p-1 text-secondary-foreground">
                                {row.type || "-"}
                            </code>
                        </TableCell>
                        <TableCell>{row.dimension || "-"}</TableCell>
                        {isInput ? (
                            <TableCell>{row.default || "-"}</TableCell>
                        ) : null}
                    </TableRow>
                ))}
            </TableBody>
        </Table>
    );
}
