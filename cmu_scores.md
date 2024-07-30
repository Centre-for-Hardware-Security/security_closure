## Best Scores (with security techniques):
|   DESIGN   |   ROWS   |   COLS   |   OVERALL   |   DES   |   TI   |   FSP_FI   | Comments |
|   :---    |   :---:  |   :---:  |    :---:    | :---:   |  :---: |    :---:   | :---: |
| AES_1	|   |   |   |   |   |   | |
| AES_2	|   |   |   |   |   |   | |
| AES_3	|   |   |   |   |   |   | |
| Camellia|   |   |   |   |   |   | |
| CAST	|  |   |   |   |   |   | |
| MISTY	|  77  |  570  |  0.18137  |  0.31822  |  0.17791  |  0.96204  |  2 hard placement blockage |
| OpenMSP430_1| 67 | 495  |  0.20296 |  0.39509 | 0.21500  | 0.81241  | 3 hard placement blockage |
| OpenMSP430_2|  72  |  530  |  0.32075 |  0.49097  | 0.38169 |  0.92491  |  1 hard placement blockage  |
| PRESENT |   |   |   |   |   |   | |
| SEED	|   |   |   |   |   |   | |
| SPARX	|   |   |   |   |   |   | |
| TDEA	|   |   |   |   |   |   | |

<br />

## Best Scores (w/o security techniques):
|   DESIGN   |   ROWS   |   COLS   |   OVERALL   |   DES   |   TI   |   FSP_FI   | Comments |
|   :---    |   :---:  |   :---:  |    :---:    | :---:   |  :---: |    :---:   | :---: |
| AES_1	|  138 | 986 | 0.24539 | 0.45772 | 0.30393 | 0.76831 | Did not experiment with col/row number, just kept the same from AES_3 |
| AES_2	|  138 | 986 | 0.25893 | 0.42388 | 0.09199 | 1.12970 | No security tricks |
| AES_3	|  138 | 986 | 0.29901 | 0.47597 | 0.41792 | 0.83853 | No security tricks |
| Camellia| 70 | 503  | 0.15319  | 0.32868  |  0.11353  | 0.81861  | No security tricks |
| CAST	|  92 | 630  | 0.14779  |  0.34625 | 0.09264  | 0.76104  | No security tricks |
| MISTY	|  76  |  580  |  0.23603  |  0.40176  |  0.08524  |  1.08973  |  des_perf_setup_WNS=-0.024, des_perf_setup_TNS=-0.027 |
| OpenMSP430_1| |   |   |   |   |   | |
| OpenMSP430_2|  77  |  490  |  0.38600  |  0.54341  |  0.54982  |  0.87085  |  des_perf_setup_WNS=-0.239, des_perf_setup_TNS=-0.410  |
| PRESENT | 38 | 240 | 0.19968 | 0.31240 | 0.38695 | 0.89143 | No security yet, M5 stripes with offset=4, s2s=14. Can probably be squeezed further |
| SEED	|  82  |  675  |  0.60332  |  1.18682  |  0.21626  |  0.80044  |  des_perf_setup_WNS=-0.892, des_perf_setup_TNS=-33.599, placement density=95.17%  |
| SPARX	| 136 |  530  |  0.24748  |  0.38781  |  0.11967  |  1.15663  |  des_perf_setup_WNS=1.114, placement density=97.67%  |
| TDEA	|  44  |  314  |  0.70986  |  0.62475  |  1.12269  |  1.14975  |  des_perf_setup_WNS=-0.023, des_perf_setup_TNS=-0.051  |

Best scores from summer 2024 onwards (CMU) - DES (Design Score) || TI (Trojan Score) || FSP_FI (Probing Score)
