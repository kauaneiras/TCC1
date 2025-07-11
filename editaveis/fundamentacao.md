### **Dimensionamento Automático e Gerenciamento de Recursos**

O dimensionamento automático, ou *autoscaling*, é uma funcionalidade que permite que a infraestrutura de nuvem ajuste automaticamente a capacidade de recursos em resposta a mudanças na demanda. Em vez de provisionar manualmente novas máquinas virtuais ou ajustar a capacidade de CPU e memória, o sistema de *autoscaling* monitora métricas de desempenho, como utilização de CPU, memória e tráfego de rede, e, com base em políticas predefinidas, adiciona ou remove recursos dinamicamente (AUTOR6, ANO6).

Existem dois tipos principais de dimensionamento automático:

#### **Escalonamento Vertical, ou *Vertical Scaling***
Refere-se ao aumento ou diminuição dos recursos, como CPU e RAM, de uma única instância de máquina virtual. Se uma VM estiver com alta utilização de CPU, o escalonamento vertical pode aumentar a quantidade de CPU ou RAM dessa VM \cite{murthy2014, pazynin2024}.

#### **Escalonamento Horizontal, ou *Horizontal Scaling***
Envolve a adição ou remoção de instâncias de máquinas virtuais inteiras para distribuir a carga de trabalho. Se a demanda aumenta, novas VMs são provisionadas; se a demanda diminui, VMs ociosas são desligadas. Este tipo de escalonamento é mais flexível e escalável, sendo ideal para aplicações que podem ser distribuídas entre múltiplas instâncias \cite{murthy2014, pazynin2024}.

### **Políticas Avançadas de Alocação**

Para otimizar ainda mais a alocação de recursos em ambientes virtualizados, especialmente em cenários de múltiplos usuários, são empregadas políticas avançadas de gerenciamento, como *Fair-Share* e *Ballooning*.

#### **Políticas de *Fair-Share***
As políticas de *Fair-Share* garantem que os recursos de CPU sejam distribuídos de forma equitativa entre as máquinas virtuais, de acordo com as prioridades ou pesos predefinidos. Em vez de alocar uma quantidade fixa de CPU para cada VM, o *Fair-Share* permite que uma VM utilize mais recursos de CPU quando outras VMs estão ociosas, e reduz sua alocação quando a demanda geral do sistema aumenta \cite{kim2019}. Isso garante que, mesmo em momentos de alta concorrência por recursos, todas as VMs recebam uma parcela justa do poder de processamento disponível, evitando que uma única VM monopolize os recursos e prejudique o desempenho das demais. 

#### ***Ballooning***
O *Ballooning* é uma técnica de gerenciamento de memória que permite ao hipervisor recuperar memória não utilizada de máquinas virtuais e a realocar para outras VMs que necessitam de mais recursos. Um *driver* de *ballooning* é instalado dentro do sistema operacional convidado da VM. Quando o hipervisor detecta que a memória está escassa no host físico, ele "infla" o *balloon* dentro de uma VM, fazendo com que o sistema operacional convidado libere memória para o hipervisor. Essa memória liberada pode então ser alocada para outras VMs que estão com alta demanda, evitando que a memória seja subutilizada por uma VM e prejudique o desempenho das demais \cite{wang2015}.

## Imagens Base Compartilhadas

\section{Imagens Base Compartilhadas}

Em ambientes de computação em nuvem, a eficiência no provisionamento de máquinas virtuais (VMs) é amplamente otimizada pelo uso de imagens base compartilhadas \cite{jin2009}. Uma imagem base é um modelo pré-configurado de um sistema operacional, que pode incluir aplicações e configurações específicas, servindo como ponto de partida para a criação de novas VMs. Em vez de instalar e configurar cada VM do zero, os provedores de nuvem, ou no caso de nuvens privadas, é disponibilizado imagens para que os usuários possam rapidamente lançar instâncias prontas para uso \cite{jin2009}.

Essa abordagem oferece diversas vantagens:

\begin{description}
    \item[Eficiência de Armazenamento]: Múltiplas VMs podem compartilhar a mesma imagem base, reduzindo significativamente o espaço em disco necessário, pois apenas as alterações específicas de cada VM são armazenadas separadamente. Isso é particularmente útil em ambientes com grande número de usuários, como o Lab Telecom, onde diversas VMs podem ser criadas a partir de uma imagem padronizada com softwares licenciados \cite{jin2009}.
    \item[Rapidez no Provisionamento]: O lançamento de novas VMs é muito mais rápido, uma vez que o processo envolve apenas a criação da camada de escrita e a vinculação à imagem base, em vez de uma instalação completa do sistema operacional e das aplicações \cite{jin2009}.
    \item[Facilidade de Gerenciamento e Atualização]: As imagens base podem ser atualizadas centralizadamente. Ao atualizar uma imagem base, todas as novas VMs lançadas a partir dela já incorporarão as últimas modificações. Para VMs existentes, pode-se optar por migrar para a nova versão da imagem ou manter a versão atual, dependendo da política de atualização \cite{jin2009}.
    \item[Consistência]: Garante que todas as VMs provisionadas a partir da mesma imagem base tenham um ambiente consistente e padronizado, o que simplifica o suporte e a resolução de problemas \cite{jin2009}.
\end{description}