# Zotero 与引用管理约定

1. Zotero 负责保存 PDF、网页快照、附件和原始条目。
2. Better BibTeX 负责稳定 citation key；不要手动频繁改 key。
3. BibTeX 导出文件可放在本地或 `references/references.bib`，但不要把含私人附件路径的数据库提交到 Git。
4. 本仓库中的 `paper_id` 是内部稳定 ID；DOI/PMID 是外部标识，缺失时可以为空。
5. 每次导出后运行 `Rscript scripts/validate_literature.R`。
6. 一篇论文可以有多个 claim；claim 的来源必须指向页码、图、表或补充材料。
7. 只把可公开的 citation metadata 提交到远程仓库；PDF 和未发表数据留在本地。

推荐字段：

- 文献：DOI、PMID、标题、年份、期刊、物种、模型、组织、assay、样本设计、accession。
- 证据：原文结论、证据类型、图表、模型、可信度、重复验证状态。
- 数据集：accession、下载日期、样本数、原始数据地址、处理后数据地址、许可证。

`saccelerator.bib` is a standalone citation file for P021 because the shared bibliography is preserved until a complete-file update is available.
