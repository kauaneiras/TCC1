### **Matriz Redundante de Discos Independentes, ou RAID**

A Matriz Redundante de Discos Independentes, ou RAID, do inglês *Redundant Array of Independent Disks*, é uma tecnologia de virtualização de armazenamento de dados que combina múltiplos discos rígidos físicos em uma única unidade lógica \cite{lee2021}. Os objetivos principais são a redundância de dados para maior confiabilidade, a melhoria de desempenho através do acesso paralelo, ou uma combinação de ambos \cite{lee2021;techtarget2023}. A tecnologia distribui e replica dados entre os discos de diferentes maneiras, dependendo da configuração escolhida.

Diferentes configurações, conhecidas como níveis de RAID, oferecem balanços distintos entre desempenho e confiabilidade. Embora a tecnologia RAID seja amplamente utilizada, a falta de um padrão universal para o formato de dados no disco historicamente dificultava a migração de dados entre sistemas de diferentes fornecedores. Para resolver isso, organizações como a Storage Networking Industry Association, ou SNIA, trabalham na criação de especificações, como a *Common RAID Disk Data Format*, ou DDF. O objetivo desses padrões é definir uma estrutura de dados comum que descreve como as informações são formatadas nos discos, permitindo um nível básico de interoperabilidade e facilitando a migração de dados *in-place* \cite{snia2016}.

### **Níveis de RAID Fundamentais**

Existem vários níveis de RAID, no entanto, os mais comuns e mais utilizados são o RAID 0, o RAID 1, o RAID 5, o RAID 6 e o RAID 10 exibidos na tabela X.

### **Tabela X - Comparativa dos Níveis de RAID**

| Nível de RAID | Vantagens Principais | Desvantagens Principais | Mínimo de Discos |
| :--- | :--- | :--- | :--- |
| **RAID 0** | Excelente desempenho de leitura e escrita; Custo baixo; 100% de aproveitamento da capacidade. | Nenhuma tolerância a falhas. A falha de um disco resulta na perda total de dados. | 2 |
| **RAID 1** | Alta redundância; Recuperação de falhas simples e rápida; Bom desempenho de leitura. | 50% de aproveitamento da capacidade; Custo por GB mais elevado. | 2 |
| **RAID 5** | Bom equilíbrio entre desempenho, capacidade e redundância; Suporta a falha de um disco. | Desempenho de escrita moderado; Reconstrução lenta e que degrada a performance. | 3 |
| **RAID 6** | Alta redundância, suportando a falha de até dois discos; Maior segurança para dados críticos. | Desempenho de escrita inferior ao RAID 5; Reconstrução ainda mais lenta. | 4 |
| **RAID 10** | Excelente desempenho geral e alta redundância; Reconstrução rápida. | Custo muito elevado; 50% de aproveitamento da capacidade. | 4 |
Fonte: Feito pelo autor, baseado em \cite{techtarget2023;lee2021;snia2016}. 


#### RAID 0 (\textit{Stripping})
Este nível distribui os dados em blocos, processo conhecido como *stripping*, por todos os discos do arranjo. Imagine um arquivo grande sendo dividido em várias partes, com cada parte sendo salva em um disco diferente ao mesmo tempo.

* **Vantagens**: oferece um aumento significativo no desempenho de leitura e escrita, pois as operações são paralelizadas entre os discos. É a configuração com melhor performance \cite{techtarget2023}.
* **Desvantagens**: não oferece qualquer redundância de dados, pois não utiliza paridade. A falha de um único disco resulta na perda total de todos os dados do arranjo \cite{snia2016}.
* **Mínimo de discos**: 2.

#### RAID 1 (\textit{Mirroring})
O RAID 1 duplica, ou espelha, os dados integralmente em dois ou mais discos. Cada dado escrito em um disco é simultaneamente escrito em outro, criando uma cópia exata \cite{snia2016}.

* **Vantagens**: Proporciona alta redundância e tolerância a falhas. Se um disco falhar, os dados permanecem intactos e acessíveis no disco espelhado. O desempenho de leitura pode ser melhorado, pois as leituras podem ser feitas de qualquer disco do par \cite{techtarget2023}.
* **Desvantagens**: O custo por gigabyte é alto, pois a capacidade útil de armazenamento é de apenas 50\% do total de discos. O desempenho de escrita é limitado pela velocidade do disco mais lento do conjunto \cite{techtarget2023}.
* **Mínimo de discos**: 2.

#### RAID 5 (Paridade Distribuída)
Este nível combina a distribuição de dados do RAID 0 com um sofisticado sistema de paridade. Os dados e as informações de paridade são distribuídos rotativamente por todos os discos do arranjo \cite{snia2016}. A paridade é um tipo de dado calculado que permite reconstruir a informação de um disco que falhou.

* **Vantagens**: Oferece um excelente equilíbrio entre desempenho, capacidade de armazenamento e redundância. Ele pode tolerar a falha de um único disco sem perda de dados \cite{techtarget2023}.
* **Desvantagens**: O desempenho de escrita é inferior ao do RAID 0, pois exige o cálculo da paridade. Após uma falha, o processo de reconstrução dos dados no disco novo pode ser demorado e impactar o desempenho e a estabilidade do arranjo \cite{lee2021}.
* **Mínimo de discos**: 3.

#### RAID 6 (Dupla Paridade)
Similar ao RAID 5, o RAID 6 também distribui dados, mas utiliza dois blocos de paridade independentes e rotativos \cite{snia2016}.

* **Vantagens**: Oferece um nível de redundância superior ao RAID 5, permitindo que o arranjo tolere a falha simultânea de até dois discos sem qualquer perda de dados \cite{lee2021, snia2016}. É ideal para sistemas críticos que necessitam de alta disponibilidade.
* **Desvantagens**: O desempenho de escrita é mais lento que o do RAID 5 devido à sobrecarga de cálculo dos dois blocos de paridade. A reconstrução de um arranjo RAID 6 é ainda mais demorada \cite{lee2021}.
* **Mínimo de discos**: 4.

### **RAID Híbrido: RAID 10**
Níveis de RAID podem ser combinados, ou aninhados, para unir as vantagens de diferentes configurações. A especificação DDF refere-se a eles como Níveis de RAID Secundários, ou *Secondary RAID Levels* \cite{snia2016}. O RAID 10, ou RAID 1+0, é a combinação mais comum. Nele, os dados são espelhados em pares e, em seguida, esses pares espelhados são distribuídos.

* **Vantagens**: Oferece altíssimo desempenho de leitura e escrita e excelente redundância. A reconstrução é rápida, pois apenas os dados do par espelhado afetado precisam ser copiados \cite{techtarget2023}.
* **Desvantagens**: É a opção mais cara, exigindo o dobro do número de discos para a capacidade desejada, com uma utilização de 50% \cite{techtarget2023}.
* **Mínimo de discos**: 4.


## Elasticidade e Provisionamento Dinâmico

### Dimensionamento automático


### Políticas *Fair-Share* e *Ballooning*


## Imagens Base Compartilhadas


## Trabalhos Relacionados


## Síntese dos Conceitos



UBUNTU. Ubuntu Server Documentation. Brasília, DF: Canonical, 2025. Disponível em: https://documentation.ubuntu.com/server/. Acesso em: 9 jul. 2025.

REDDY, P. Vijaya Vardhan; RAJAMANI, Lakshmi. Virtualization overhead findings of four hypervisors in the CloudStack with SIGAR. In: WORLD CONGRESS ON INFORMATION AND COMMUNICATION TECHNOLOGIES (WICT), 4., 2014, Malacca. Proceedings… Malacca: IEEE, 2014. p. 110-115. DOI: 10.1109/wict.2014.7077318. Disponível em: https://ieeexplore.ieee.org/document/7077318. Acesso em: 9 jul. 2025.