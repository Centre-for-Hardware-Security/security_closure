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
| SEED	|  88 | 650 | 0.14881  |0.31765  | 0.15846  |0.77848  | 5 hard placement blockage |
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
| OpenMSP430_1| 67 | 495  | 0.17335  | 0.40213  |  	0.06895 | 0.79321  | |
| OpenMSP430_2|  72  |  540 |  0.31723  |  0.51734  |  0.38659  |  0.83982  |  des_perf_setup_WNS=-0.020, des_perf_setup_TNS=-0.041  |
| PRESENT | 30 | 225 | 0.15240 | 0.29586 | 0.00001 | 1.03021 | No security yet, M5 stripes with offset=4, s2s=14. |
| SEED	|  88  |  650  |  0.16131  |  0.34430  |  0.15846  |  0.77855  |  density=93.170%  |
| SPARX	| 100 |  720  |  0.17924  | 0.34243  |  0.13783 |  0.90906  |   |
| TDEA	|  44  |  314  |  0.70986  |  0.62475  |  1.12269  |  1.14975  |  des_perf_setup_WNS=-0.023, des_perf_setup_TNS=-0.051  |

Best scores from summer 2024 onwards (CMU) - DES (Design Score) || TI (Trojan Score) || FSP_FI (Probing Score)
