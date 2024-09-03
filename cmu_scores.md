## Best Scores (with security techniques):
| DESIGN | ROWS | COLS | OVERALL | DES | TI | FSP_FI | Comments |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | --- |
| AES_1	| 136 | 984 | 0.16627 | 0.39700 | 0.00001 | 0.83763 | <li>converges after 1 call to trojan_aware_blockage.tcl </li> | 
| AES_2	| 135 | 991 | 0.23522 | 0.38944 | 0.06036 | 1.14762 | <li>degrades after 17 calls to trojan_aware_blockage.tcl </li> <li>1 region remains unsolved</li>|
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
| AES_1	| 136 | 984 | 0.17857 | 0.39701 | 0.06178 | 0.83782 | <li>density is 95.79%</li> <li>has 1 vulnerable region</li> | 
| AES_2	| 135 | 991 | 0.23946 | 0.38925 | 0.07616 | 1.15423 | <li>density is 95.80%</li> <li>has 3 vulnerable regions </li> |
| AES_3	| 138 | 989 | 0.18797 | 0.47916 | 0.00001 | 0.78457 | <li>density is 94.47%, advanced flow</li> <li>tried other similar sizes but got nearly the same score</li>|
| Camellia | 70 | 498 | 0.14737 | 0.32246 | 0.08097 | 0.83306 | <li>density is 95.71%, advanced flow</li> |
| CAST | 91 | 611 | 0.14289 | 0.30784 | 0.11054 | 0.81784 | <li>density is 94.34%</li> <li>timing closes with multiple opt calls </li> |
| MISTY	| 75 | 574 | 0.13705 | 0.30275 | 0.11097 | 0.79441 | <li>density is 95.20%, advanced flow</li> |
| OpenMSP430_1| 68 | 496 | 0.18306 | 0.38753 | 0.08560 | 0.85916 | <li>density is 96.85% (!).</li> <li> previous solution had better score but scripts were not valid</li> |
| OpenMSP430_2 | 72 | 541 | 0.33122 | 0.47800 | 0.42078 | 0.96510 | <li>density is 93.43%</li> <li> previous solution had better score but scripts were not valid</li> |
| PRESENT | 30 | 214 | 0.11254 | 0.26014 | 0.00001 | 0.86526 |  <li>density is 97.26% (!) </li> |
| SEED | 88 | 650 | 0.14564 | 0.30816 | 0.14392 | 0.80130 | <li>density is 92.57%, might be possible to push further</li> |
| SPARX	| 99 | 717 | 0.17210 | 0.37311 | 0.08334 | 0.83921 | <li>density is 97.71% (!)</li> |
| TDEA |  43  | 325 | 0.26738 | 0.38699 | 0.47238 | 0.90946 | <li>density is 94.98%</li>  <li>this design is very tricky, several floorplan configurations lead to DRCs. 42r/325c gives better result w/ 1 DRC </li>|

Best scores from summer 2024 onwards (CMU) - DES (Design Score) || TI (Trojan Score) || FSP_FI (Probing Score)
