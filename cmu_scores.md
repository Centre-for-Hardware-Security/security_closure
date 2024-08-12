## Best Scores (with security techniques):
| DESIGN | ROWS | COLS | OVERALL | DES | TI | FSP_FI | Comments |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | --- |
| AES_1	|   |   |   |   |   |   | |
| AES_2	|   |   |   |   |   |   | |
| AES_3	|   |   |   |   |   |   | |
| Camellia |   |   |   |   |   |   | |
| CAST |  |   |   |   |   |   | |
| MISTY	| 77 | 570 | 0.18137 | 0.31822 | 0.17791 | 0.96204 | 2 hard placement blockage |
| OpenMSP430_1 | 67 | 495 | 0.20296 | 0.39509 | 0.21500 | 0.81241 | 3 hard placement blockage |
| OpenMSP430_2 | 72 | 530 | 0.32075 | 0.49097 | 0.38169 | 0.92491 | 1 hard placement blockage |
| PRESENT | 30 | 215 | 0.11480 | 0.26701 | 0.00001 | 0.85988 |  <li>s2s=14</li> <li>2 blockages were sufficient (maybe got lucky) </li> |
| SEED | 88 | 650 | 0.14881 | 0.31765 | 0.15846 | 0.77848 | 5 hard placement blockage |
| SPARX	|   |   |   |   |   |   | |
| TDEA |   |   |   |   |   |   | |

<br />

## Best Scores (w/o security techniques):
| DESIGN | ROWS | COLS | OVERALL | DES | TI | FSP_FI | Comments |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | --- |
| AES_1	| 137 | 986 | 0.16836 | 0.44179 | 0.00001 | 0.76216 | <li>density is 96.61%</li> <li>uses "advanced" reference flow</li> | 
| AES_2	| 138 | 988 | 0.25058 | 0.39522 | 0.07074 | 1.19732 | <li>density is 94.39%. higher than that and timing closure is really hard</li> |
| AES_3	| 138 | 989 | 0.18797 | 0.47916 | 0.00001 | 0.78457 | <li>density is 94.47%, advanced flow</li> <li>tried other similar sizes but got nearly the same score</li>|
| Camellia | 70 | 503 | 0.15319 | 0.32868 |  0.11353 | 0.81861 | <li>No security tricks</li> |
| CAST | 92 | 630 | 0.14779 | 0.34625 | 0.09264 | 0.76104 | <li>No security tricks</li> |
| MISTY	| 76 | 580 | 0.23603 | 0.40176 | 0.08524 | 1.08973 | <li>des_perf_setup_WNS=-0.024</li> <li>des_perf_setup_TNS=-0.027</li> <li>core to inner ring offset=.095</li> |
| OpenMSP430_1| 67 | 495 | 0.17335 | 0.40213 | 0.06895 | 0.79321 | <li>core to inner ring offset=.095</li> <li>outer ring to chip edge vert. offset=1.66</li> <li>outer ring to chip edge horiz. offset=1.78</li> |
| OpenMSP430_2 | 72 | 540 | 0.31723 | 0.51734 | 0.38659 | 0.83982 | <li>des_perf_setup_WNS=-0.020</li> <li>des_perf_setup_TNS=-0.041</li> <li>core to inner ring offset=.095</li> <li>outer ring to chip edge vert. offset=1.66</li> <li>outer ring to chip edge horiz. offset=1.78</li> |
| PRESENT | 30 | 215 | 0.12775 | 0.26651 | 0.09641 | 0.86227 |  <li>s2s=14</li> <li>use of `opt_power -post_route -force` before opt_design -post_route </li> |
| SEED | 88 | 650 | 0.16131 | 0.34430 | 0.15846 | 0.77855 | <li>density=93.170%</li> |
| SPARX	| 100 | 720 | 0.17924 | 0.34243 | 0.13783 | 0.90906 | <li>core to inner ring offset=.095</li> |
| TDEA |  44  | 320 | 0.38448 | 0.41732 | 0.68537 | 1.15728 | <li>core to inner ring offset=.095</li> <li>outer ring to chip edge vert. offset=1.66</li> <li>outer ring to chip edge horiz. offset=1.78</li> |

Best scores from summer 2024 onwards (CMU) - DES (Design Score) || TI (Trojan Score) || FSP_FI (Probing Score)
