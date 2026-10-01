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

## 按功能使用近期方法

近期方法已经按科研问题接入 [nature-methods-bioinformatics-catalog](https://github.com/Threezs/nature-methods-bioinformatics-catalog)：

| 功能 | 入口 | 运行状态 |
|---|---|---|
| 输入审计 | R/00_input_audit.R / python/00_input_audit.py | smoke-tested |
| 单细胞变换与特征排序 | R/01_single_cell_transformations.R / R/02_feature_selection_benchmark.R | baseline-function |
| 轨迹与命运 | python/01_cellrank2_template.py | runtime-required |
| 长读长与 DTU | R/03_bambu_long_read.R / R/04_satuRn_dtu.R | reference/transcript-input-required |
| foundation model、空间和跨物种 | python/02–07 | manifest-only |
| Novae 空间域和组织架构 | python/19_novae_manifest.py | manifest-only |

文献阅读时，先记录输入契约、实验单位、软件/权重版本和 benchmark，再决定方法是否适合自己的小鼠 APAP、IR 或 CRLM 数据。对于 CellRank、embedding 和 niche 输出，阅读卡片要继续追踪 sample/donor 汇总和独立验证。完整的功能选择说明见 catalog 的 docs/function_map.md，近期论文综合见 literature/reviews/recent_methods_2023_2026.qmd。


## 2026 方法目录更新

| 新增条目 | 功能 | 阅读时先问什么 |
|---|---|---|
| Mellon (P012) | cell-state density、时间连续化 | density 基于哪一种 representation，是否保留 sample/time 信息？ |
| MISO (P013) | 多模态空间组学整合 | 所有模态是否共享 spot/cell key、坐标和预处理版本？ |
| SCMMIB (P014) | paired/unpaired/mosaic 整合 benchmark | 当前任务和评价指标是什么，是否把 benchmark 排名误读成普适结论？ |

以上条目与 `catalog.csv` 的 `execution_mode` 对齐；manifest 生成只说明输入契约已记录，不等于官方模型已完成推理。


## 2026 评估与长读长扩展

- **P015 / scMultiBench**：把多模态整合拆成 reduction、batch correction、clustering、classification、imputation、feature selection 和 spatial registration 任务；阅读时必须记录任务、模态结构和 split。
- **P016 / NaRMBench**：面向 nanopore direct-RNA 修饰检测工具；阅读时必须记录 RNA002/RNA004 chemistry、ground truth、是否重训练和 site-level calibration。

两者都与 catalog 的 `manifest-only` 状态对齐：先登记输入契约和运行环境，再引用 benchmark 数值。

## 2026 蛋白上下文扩展

- **P017 / PINNACLE**：把单细胞表达、PPI 网络和 cell-type/tissue 层级接入 context-aware protein representation；阅读时固定网络版本、上下文标签、checkpoint 和 held-out target-ranking split。
- 入口：`python/14_pinnacle_manifest.py`，当前状态为 `manifest-only`，不把配置文件误读为已完成模型推理。

## 2025 多模态轨迹扩展

- **P018 / PHLOWER**：用多模态单细胞数据和 Hodge 分解处理复杂、多分支分化轨迹；阅读时固定共享 cell ID、root/direction、模态预处理和 branch stability。
- 入口：`python/15_phlower_manifest.py`，当前状态为 `manifest-only`；分支树和候选调控因子必须配独立验证。
## 2025 spatial data infrastructure

- **P019 / SpatialData**：把不同平台的空间组学表、图像、labels、shapes、points 和坐标变换组织成可互操作的数据框架；阅读时固定元素类型、坐标系、单位、变换链、平台 reader 和存储格式。
- 入口：`python/16_spatialdata_manifest.py`，当前状态为 `manifest-only`；它不自动修复 segmentation、registration 或组织混杂。
## 2026 通用 Python 工具层

- **P020 / scikit-bio**：覆盖序列、feature table、距离、多样性、分类、taxonomy 和系统发育操作；阅读时固定输入格式、序列/样本 ID、metadata、距离/树约定和统计设计。
- 入口：`python/17_scikit_bio_manifest.py`，当前状态为 `manifest-only`；通用库调用不等于实验设计或生物学结论已经成立。
## 2026 空间聚类共识扩展

- **P021 / SACCELERATOR**：把空间感知聚类方法、跨平台数据集、空间指标和专家反馈放在可扩展框架中；阅读时固定方法版本、数据集 split、坐标、ARI/NMI、CHAOS/PAS/entropy 和 expert-review protocol。
- 入口：`python/18_saccelerator_manifest.py`，当前状态为 `manifest-only`；手工标签不是自动真值，共识结果要回到原始图像和独立生物学验证。


## 2025–2026 空间 foundation model 扩展

- **P022 / Novae**：图结构 foundation model，面向 spot/cell 空间域推断，并提供跨 gene panel、组织和技术平台的迁移、原生 batch-effect correction、空间可变基因/通路和 tissue-slide architecture 分析。
- 入口：`python/19_novae_manifest.py`，当前状态为 `manifest-only`；运行前固定 SpatialData 元素和坐标、gene-panel coverage、batch/section split、checkpoint hash，并用 held-out section、marker 或图像标注验证。
- 官方代码：<https://github.com/prism-oncology/novae>；模型权重不随本工作台提交。
