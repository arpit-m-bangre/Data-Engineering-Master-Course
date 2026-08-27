import sys
import os
import markdown
import subprocess

def md_to_pdf(input_md, output_pdf=None, css_file=None):
    if not os.path.exists(input_md):
        print(f"Error: Input file '{input_md}' not found.")
        sys.exit(1)
    
    if output_pdf is None:
        base_name = os.path.splitext(input_md)[0]
        output_pdf = f"{base_name}.pdf"
    
    with open(input_md, "r", encoding="utf-8") as f:
        md_text = f.read()
    
    html_body = markdown.markdown(md_text, extensions=['extra', 'tables', 'fenced_code', 'toc'])
    
    default_css = """
    @page {
        margin: 20mm 15mm 20mm 15mm;
        @bottom-right {
            content: counter(page);
            font-size: 9pt;
            color: #64748b;
        }
    }
    body {
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
        font-size: 10.5pt;
        line-height: 1.6;
        color: #1e293b;
    }
    h1, h2, h3, h4 {
        color: #0f172a;
        margin-top: 1.2em;
        margin-bottom: 0.5em;
        font-weight: 700;
    }
    h1 { font-size: 18pt; border-bottom: 2px solid #e2e8f0; padding-bottom: 6px; }
    h2 { font-size: 14pt; border-bottom: 1px solid #e2e8f0; padding-bottom: 4px; }
    h3 { font-size: 12pt; }
    code {
        font-family: "Consolas", "Courier New", monospace;
        background-color: #f1f5f9;
        padding: 2px 5px;
        border-radius: 4px;
        font-size: 9.5pt;
        color: #0f172a;
    }
    pre {
        background-color: #0f172a;
        color: #f8fafc;
        padding: 12px 14px;
        border-radius: 6px;
        font-size: 9pt;
        line-height: 1.45;
    }
    pre code {
        background-color: transparent;
        color: inherit;
        padding: 0;
    }
    table {
        border-collapse: collapse;
        width: 100%;
        margin: 15px 0;
    }
    th, td {
        border: 1px solid #cbd5e1;
        padding: 7px 10px;
        text-align: left;
    }
    th {
        background-color: #f8fafc;
        font-weight: 600;
    }
    tr:nth-child(even) {
        background-color: #f8fafc;
    }
    blockquote {
        border-left: 4px solid #3b82f6;
        margin: 10px 0;
        padding: 6px 14px;
        background-color: #eff6ff;
        color: #1e3a8a;
    }
    """
    
    custom_css = ""
    if css_file and os.path.exists(css_file):
        with open(css_file, "r", encoding="utf-8") as f:
            custom_css = f.read()
    
    full_html = f"""<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style>
{default_css}
{custom_css}
</style>
</head>
<body>
{html_body}
</body>
</html>"""
    
    temp_html = os.path.join(os.environ.get("TEMP", "."), "temp_md_render.html")
    with open(temp_html, "w", encoding="utf-8") as f:
        f.write(full_html)
    
    weasyprint_exe = r"C:\Users\Arpik\AppData\Local\Programs\mdPDFinator\dist\weasyprint.exe"
    
    cmd = [weasyprint_exe, temp_html, output_pdf]
    print(f"[mdPDFinator] Converting '{input_md}' -> '{output_pdf}' ...")
    subprocess.run(cmd, check=True)
    print(f"[mdPDFinator] SUCCESS: Generated '{output_pdf}'")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: mdpdfinator <input.md> [output.pdf] [custom_style.css]")
        sys.exit(0)
    
    in_file = sys.argv[1]
    out_file = sys.argv[2] if len(sys.argv) > 2 else None
    css = sys.argv[3] if len(sys.argv) > 3 else None
    
    md_to_pdf(in_file, out_file, css)
