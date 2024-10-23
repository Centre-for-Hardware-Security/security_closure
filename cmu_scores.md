Best scores from summer 2024 onwards - DES (Design Score) || TI (Trojan Score) || FSP_FI (Probing Score)

## Best Scores (w/o security techniques):
| DESIGN | ROWS | COLS | OVERALL | DES | TI | FSP_FI | Comments |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | --- |
| AES_1	| 136 | 984 | 0.17857 | 0.39701 | 0.06178 | 0.83782 | <li>density is 95.79%</li> <li>has 1 vulnerable region</li> | 
| AES_2	| 135 | 991 | 0.23946 | 0.38925 | 0.07616 | 1.15423 | <li>density is 95.80%</li> <li>has 3 vulnerable regions</li> |
| AES_3	| 135 | 991 | 0.27686 | 0.44404 | 0.41044 | 0.83657 | <li>density is 95.77%</li> <li>has 1 vulnerable region</li>|
| Camellia | 72 | 480 | 0.14906 | 0.31809 | 0.09304 | 0.84419 | <li>density is 96.21%</li> <li>has 2 vulnerable regions</li>|
| CAST | 91 | 617 | 0.14289 | 0.30784 | 0.11054 | 0.81784 | <li>density is 94.34%</li> <li>has 3 vulnerable regions</li> |
| MISTY	| 74 | 578 | 0.13320 | 0.30200 | 0.07449 | 0.80767 | <li>density is 95.54%</li> <li>has 4 vulnerable regions </li> |
| OpenMSP430_1| 69 | 492 | 0.18068 | 0.38589 | 0.07942 | 0.85700 | <li>density is 95.91%</li> <li> has 3 vulnerable regions</li> |
| OpenMSP430_2 | 70 | 550 | 0.29791 | 0.47349 | 0.29050 | 0.96786 | <li>density is 94.24%</li> <li>has 3 vulnerable regions</li>|
| PRESENT | 30 | 214 | 0.11254 | 0.26014 | 0.00001 | 0.86526 |  <li>density is 97.26% </li> <li> has 0 vulnerable regions</li> |
| SEED | 87 | 647 | 0.14527 | 0.30673 | 0.16064 | 0.78656 | <li>density is 94.29%</li> <li>has 5 vulnerable regions </li> |
| SPARX	| 99 | 717 | 0.17210 | 0.37311 | 0.08334 | 0.83921 | <li>density is 97.71% </li> <li>has 9 vulnerable regions </li> |
| TDEA |  43  | 325 | 0.26738 | 0.38699 | 0.47238 | 0.90946 | <li>density is 94.98%</li>  <li>this design is very tricky, several floorplan configurations lead to DRCs. 42r/325c gives better result w/ 1 DRC </li>|

## Best Scores (with security techniques for TI):
| DESIGN | ROWS | COLS | OVERALL | DES | TI | FSP_FI | Comments |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | --- |
| AES_1	| 136 | 984 | 0.16630 | 0.39699 | 0.00001 | 0.83780 | <li>requires 1H0V nudges on 2 cells</li> | 
| AES_2	| 135 | 991 | 0.22464 | 0.38925 | 0.00001 | 1.15423 | <li>requires 2H0V nudges on 6 cells +</li>|
| AES_3	| 135 | 991 | 0.18562 | 0.44377 | 0.00001 | 0.83657 | <li>requires 2H0V nudges on 2 cells </li>|
| Camellia | 72 | 480 | 0.13336 | 0.31770 | 0.00001 | 0.83956 | <li> requires 13H0V nudges on 5 cells </li> |
| CAST | 91 | 617 | 0.12551 | 0.30692 | 0.00001 | 0.81788 | <li>requires 10H0V nudges on 8 cells +</li> |
| MISTY	| 74 | 578 | 0.12198 | 0.30204 | 0.00001 | 0.80768 | <li>requires 20H0V nudges on 12 cells +</li> |
| OpenMSP430_1 | 69 | 492 | 0.16538 | 0.38591 | 0.00001 | 0.85709 | <li>requires 8H0V nudges on 5 cells </li> |
| OpenMSP430_2 | 70 | 550 | 0.22917 | 0.47352 | 0.00001 | 0.96796 | <li>requires 4H0V nudges on 5 cells </li> |
| PRESENT | 30 | 214 | 0.11255 | 0.26015 | 0.00001 | 0.86526 |  <li>nothing to do</li> |
| SEED | 87 | 647 | 0.12054 | 0.30617 | 0.00001 | 0.78741 | <li>requires 59H4V nudges on 39 cells +</li> |
| SPARX	| 99 | 717 | 0.16269 | 0.37094 | 0.00001 | 0.87717 | <li>requires 66H6V nudges on 61 cells </li> |
| TDEA | 43 | 325 | 0.17602 | 0.38689 | 0.00001 | 0.90994 | <li>requires 5H0V nudges on 5 cells  </li>|

## Best Scores (with security techniques for TI and FSP/FI):
| DESIGN | ROWS | COLS | OVERALL | DES | TI | FSP_FI | Comments |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | --- |
| AES_1	| 136 | 984 | 0.14129| 0.39701 | 0.00001 | 0.71179 | <li>50 nets are pushed down</li> | 
| AES_2	| 135 | 991 | 0.20896 | 0.38942 | 0.00001 | 1.07319 | <li>67 nets are pushed down+</li>|
| AES_3	| 135 | 991 | 0.17495 | 0.44368 | 0.00001 | 0.78864 | <li>28 nets are pushed down</li>|
| Camellia | 72 | 480 | 0.13319 | 0.31772 | 0.00001 | 0.83839 | <li>3 nets are pushed down</li> |
| CAST | 91 | 617 | 0.12278 | 0.30693 | 0.00001 | 0.80008 | <li>23 nets are pushed down+</li> |
| MISTY	| 74 | 578 | 0.11812 | 0.30231 | 0.00001 | 0.78144 | <li>3 nets are pushed down</li> |
| OpenMSP430_1 | 69 | 492 | 0.16518 | 0.38609 | 0.00001 | 0.85566 | <li>8 nets are pushed down</li> |
| OpenMSP430_2 | 70 | 550 | 0.22915 | 0.47415 | 0.00001 | 0.96656 | <li>13 nets are pushed down</li> |
| PRESENT | 30 | 214 | 0.10724 | 0.26029 | 0.00001 | 0.82400 |  <li>20 nets are pushed down</li> |
| SEED | 87 | 647 | 0.12059 | 0.30599 | 0.00001 | 0.78819 | <li> nets are pushed down ++</li> |
| SPARX	| 99 | 717 | 0.15878 | 0.37092 | 0.00001 | 0.85615 | <li>14 nets are pushed down </li> |
| TDEA | 43 | 325 | 0.17006 | 0.38707 | 0.00001 | 0.87872 | <li>14 nets are pushed down</li>|

<br />





