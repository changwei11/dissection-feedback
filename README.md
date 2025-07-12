# LiteTracker: Leveraging Temporal Causality for Accurate Low-latency Tissue Tracking
![LiteTracker](assets/lite-tracker-teaser.gif)

📑 **[arXiv](https://arxiv.org/abs/2504.09904)**

We propose LiteTracker, a low-latency method for tissue tracking in endoscopic video streams. LiteTracker builds on a state-of-the-art long-term point tracking method, and introduces a set of **training-free runtime optimizations**. These optimizations enable online, frame-by-frame tracking by leveraging **a temporal memory buffer** for efficient feature reuse and utilizing prior motion for **accurate track initialization**. LiteTracker demonstrates significant runtime improvements being around **7x faster than its predecessor and 2x than the state-of-the-art**. Beyond its primary focus on efficiency, LiteTracker delivers high-accuracy tracking and occlusion prediction, performing competitively on both the STIR and SuPer datasets.

## Getting Started
1. Install the required packages using pip (tested only with Ubuntu 20.04 and 22.04 with Python 3.10):
```bash
pip install -r requirements.txt
```
2. Download the pre-trained weights or train your own CoTracker3 Online model via the official [repository](https://github.com/facebookresearch/co-tracker). In our experiments, we used the [scaled weights](https://huggingface.co/facebook/cotracker3/resolve/main/scaled_online.pth) from the official repository.

3. For evaluation, download the STIR Challenge 2024 and Super datasets:
   - [STIR Challenge 2024](https://stir-challenge.github.io//stirc-2024/) and [dataset](https://zenodo.org/records/14803158)
   - [SuPer Framework website](https://sites.google.com/ucsd.edu/super-framework/) and [dataset](https://drive.google.com/open?id=1fRepcpd9tFpRoi2G7G-w9uwo7eScG9LI)


## Inference and Evaluation
### Demo and runtime analysis
The demo script runs LiteTracker on a video in a stream-line fashion, produces a video with tracking results, and prints the runtime statistics.
```bash
python demo.py -w <path/to/weights.pth> -v assets/stir-5-seq-01.mp4 -s 20 -q 0
```

### STIR Challenge 2024
STIR evaluation scripts are based on the official [repository](https://github.com/athaddius/STIRMetrics/tree/STIRC2024). Minimal modifications are made to accommodate within our framework.
```bash
bash ./launch_eval_stir.sh <path/to/STIRDataset> <path/to/weights.pth>
```

### SuPer
```bash
python ./src/eval/super/eval_super.py -d <path/to/SuPerDataset> -w <path/to/weights.pth>
```

## Acknowledgements
Special thanks to the authors of [CoTracker3](https://cotracker3.github.io/), [MFT](https://github.com/serycjon/MFT), [STIR Challenge](https://stir-challenge.github.io/), and [SuPer Framework](https://sites.google.com/ucsd.edu/super-framework/) that made this work possible.

Please cite our work if you use LiteTracker in your research:
```
@article{karaoglu2025litetracker,
  title={LiteTracker: Leveraging Temporal Causality for Accurate Low-latency Tissue Tracking},
  author={Karaoglu, Mert Asim and Ji, Wenbo and Abbas, Ahmed and Navab, Nassir and Busam, Benjamin and Ladikos, Alexander},
  journal={arXiv preprint arXiv:2504.09904},
  year={2025}
}
```



