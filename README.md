# Bioinformatics Literature Workbench

这是我的生物信息学文献阅读与知识管理工作台。它把 Zotero/BibTeX 的文献库、逐篇阅读笔记、可核查的 claim-level 证据、公开数据集登记和项目关联放在同一套轻量结构中。

## 设计目标

- **先记录元数据，再写理解**：每篇文献先进入 `data/papers.csv`，避免只有 PDF 没有可检索索引。
- **把观点拆成证据**：关键结论写入 `data/claims.csv`，注明图表、模型、证据类型、可信度和是否已有重复验证。
- **文献和项目相互连接**：用 `project_links` 标记 APAP、IR、CRLM、网络药理学、分子对接和 RNA-seq 项目。
- **R 为主，Quarto 为阅读界面**：笔记使用 QMD/Markdown，必要时用 R 生成汇总表和主题统计。
- **保留隐私边界**：PDF、未发表数据、带个人信息的导出文件和大型原始文件默认不进入 Git。

## 推荐工作流

1. 在 Zotero 中用 DOI/PMID 收录论文，并用 Better BibTeX 生成稳定 citation key。
2. 将 BibTeX 导出到本地私有位置；把核心元数据整理进 `data/papers.csv`。
3. 从 `templates/paper-note.qmd` 复制一份笔记到 `literature/notes/`。
4. 阅读时把可验证的结论写进 `data/claims.csv`，一条结论一个 claim_id。
5. 将论文涉及的公开数据集登记到 `data/datasets.csv`，记录 accession、物种、样本数和下载地址。
6. 在 `literature/reviews/` 撰写主题综合，例如 STAT3/NF-kB、SAA/LCN2-中性粒细胞或 CRLM 转移状态。
7. 提交前运行 `Rscript scripts/validate_literature.R`，检查必需列、重复 DOI 和孤立引用。

## 目录结构

~~~text
data/
├─ papers.csv       # 一篇论文一行，文献主索引
├─ claims.csv       # 一条可核查结论一行
├─ datasets.csv     # GEO/ArrayExpress/TCGA 等公开数据集
└─ mock/            # 可公开的最小演示数据

literature/
├─ inbox/           # 待整理 DOI、BibTeX 或临时文本，不提交 PDF
├─ notes/           # 每篇论文一个 .qmd 或 .md
├─ reviews/         # 按主题整合的综述性笔记
└─ protocols/       # 可复用实验与生信方法说明

references/
└─ README.md        # Zotero、Better BibTeX 和导出约定

templates/
├─ paper-note.qmd
└─ synthesis.qmd

scripts/
└─ validate_literature.R

config/
└─ literature.yml
~~~

## 字段约定

`papers.csv` 记录 DOI、PMID、研究对象、模型、组织、组学类型、样本设计、公开 accession、阅读状态和笔记路径。不要把“读过”只写在文件名中。

`claims.csv` 记录 `claim`、`figure_or_table`、`model`、`evidence_type`、`confidence`、`replication_status` 和 `relevance_to_projects`。对于“某分子导致某表型”的表述，要区分相关性、干预证据和机制证据。

## 与其他仓库的关系

- [research-compendium-template-r](https://github.com/Threezs/research-compendium-template-r)：把一次研究组织成 targets + renv + Quarto 项目。
- [rnaseq-analysis-template](https://github.com/Threezs/rnaseq-analysis-template)：把 count matrix 和样本信息接入 bulk RNA-seq 分析。
- [zotero-literature-tools](https://github.com/Threezs/zotero-literature-tools)：BibTeX、DOI、PubMed 元数据的整理工具。
- [research-evidence-notebook](https://github.com/Threezs/research-evidence-notebook)：面向机制和项目的证据矩阵。
- [bioinformatics-methods-cookbook](https://github.com/Threezs/bioinformatics-methods-cookbook)：可复用 R/Python 分析配方。

## 参考的成熟项目

本仓库借鉴公开项目的结构思想，没有复制其中的专有内容：

- [ropensci/targets](https://github.com/ropensci/targets)：声明式、可增量运行的 R 工作流。
- [r-lib/renv](https://github.com/r-lib/renv)：项目级 R 依赖锁定。
- [benmarwick/rrtools](https://github.com/benmarwick/rrtools)：research compendium 结构。
- [retorquere/zotero-better-bibtex](https://github.com/retorquere/zotero-better-bibtex)：稳定 citation key 与 BibTeX 导出。
- [fchicout/zotero-cli](https://github.com/fchicout/zotero-cli)：Zotero 命令行和审计思路。
- [neuromechanist/research-skills](https://github.com/neuromechanist/research-skills)：模块化研究工作流的组织方式。

## 使用边界

这个仓库用于研究记录和证据追踪，不替代系统综述注册、同行评议或正式数据管理计划。对于临床结论、动物实验结论和小样本组学结果，始终保留研究设计、样本量和局限性。

## 近期方法专题

近期的 Nature Methods 和相关方法论文已登记到 data/papers.csv、references/references.bib 和 literature/notes/。可直接运行的 R/Python 入口集中在 [nature-methods-bioinformatics-catalog](https://github.com/Threezs/nature-methods-bioinformatics-catalog)，覆盖：

- 单细胞计数变换和 feature selection；
- CellRank 2 轨迹/命运、多视图分析；
- Bambu 长读长转录本发现和 satuRn transcript usage；
- scGPT、scFoundation、Nicheformer、Monod 和 SATURN 的受控 manifest。

阅读这些方法时，先记录输入契约、实验单位、版本和官方代码，再把 benchmark 结果与自己的物种、组织、平台和样本量分开判断。专题综合见 literature/reviews/recent_methods_2023_2025.qmd。
