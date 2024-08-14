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
| Camellia | 70 | 498 | 0.14737 | 0.32246 | 0.08097 | 0.83306 | <li>density is 95.71%, advanced flow</li> |
| CAST | 91 | 611 | 0.14289 | 0.30784 | 0.11054 | 0.81784 | <li>density is 94.34%</li> <li>timing closes with multiple opt calls </li> |
| MISTY	| 75 | 574 | 0.13705 | 0.30275 | 0.11097 | 0.79441 | <li>density is 95.20%, advanced flow</li> |
| OpenMSP430_1| 68 | 496 | 0.18306 | 0.38753 | 0.08560 | 0.85916 | <li>density is 96.85% (!).</li> <li> previous solution had better score but scripts were not valid</li> |
| OpenMSP430_2 | 72 | 541 | 0.33122 | 0.47800 | 0.42078 | 0.96510 | <li>density is 93.43%</li> <li> previous solution had better score but scripts were not valid</li> |
| PRESENT | 30 | 214 | 0.11254 | 0.26014 | 0.00001 | 0.86526 |  <li>density is 97.26% (!) </li> |
| SEED | 88 | 650 | 0.14564 | 0.30816 | 0.14392 | 0.80130 | <li>density is 92.57%, might be possible to push further</li> |
| SPARX	| 99 | 717 | 0.17210 | 0.37311 | 0.08334 | 0.83921 | <li>density is 97.71% (!)</li> |
| TDEA |  44  | 318 | 0.31357 | 0.38783 | 0.70153 | 0.91552 | <li>density is 95.25%</li> <li>has one DRC on a power stripe that has to be investigated how to fix</li> |

Best scores from summer 2024 onwards (CMU) - DES (Design Score) || TI (Trojan Score) || FSP_FI (Probing Score)
