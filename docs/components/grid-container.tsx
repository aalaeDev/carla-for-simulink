export default function GridContainer({
    children,
}: {
    children?: React.ReactNode;
}) {
    return (
        <div className="border rounded-sm p-5 flex items-center justify-center bg-grid my-4">
            {children}
        </div>
    );
}
