## 3. Solução Proposta

Este capítulo descreve detalhadamente a solução proposta para otimizar o uso de recursos computacionais no \textit{Lab Telecom} (Laboratório Compartilhado de Ensino e Pesquisa em Telecomunicações) da Universidade de Brasília (UnB). A abordagem central envolve a implementação de uma nuvem privada baseada no OpenStack, utilizando servidores legados subutilizados e aplicando técnicas de provisionamento dinâmico de recursos para a entrega de um serviço IaaS (Infrastructure as a Service). Serão apresentados o contexto do laboratório, os recursos de hardware disponíveis, a arquitetura da nuvem proposta, os detalhes de implementação e configuração, bem como as estratégias para provisionamento dinâmico, gerenciamento de imagens de máquinas virtuais (VMs) e políticas de escalonamento. O objetivo é demonstrar como essa solução pode fornecer ambientes capazes de suprir a falta de múltiplos servidores dedicados para simulações complexas e programas de alto desempenho, como Ansys, Cadence e SolidWorks. A proposta visa fornecer multiplos ambientes isolados e eficientes para os discentes e pesquisadores do laboratório, aproveitando a infraestrutura existente e garantindo a segurança e a otimização dos recursos.


### 3.1. Contexto do Laboratório e Problemas

O cenário atual doLab Telecom apresenta desafios significativos para o desenvolvimento de atividades que demandam alto poder computacional. Com um corpo discente de aproximadamente 30 alunos ativos, e tendo contribuido com a formação de mais de 100 profissionais formados em Engenharia Eletrônica, Aeroespacial, Automotiva, de Energia e de Software, o laboratório dispõe de apenas 3 máquinas dedicadas para a execução de simulações complexas e programas de alto desempenho, como Ansys, Cadence e SolidWorks. Essa limitação de recursos computacionais resulta em longas filas de espera, restrição no acesso simultâneo e, consequentemente, um gargalo no progresso das pesquisas e projetos acadêmicos dos alunos. 

Como parte de uma instituição pública, o laboratório enfrenta fluxo de caixa irrecular, dependendo de editais de fomento que não garantem um fluxo financeiro constante. Essa realidade inviabiliza a contratação de nuvens públicas como alternativa para a alta demanda computacional. Adicionalmente, a natureza das pesquisas, que frequentemente envolvem o desenvolvimento de tecnologias patenteáveis, impõe uma barreira de segurança: o armazenamento de propriedade intelectual sensível em plataformas de terceiros. Esses obstáculos restringem a capacidade de expansão e a agilidade necessárias para a pesquisa de ponta.

Este cenário, inspirou o desenvolvimento deste trabalho, que busca a otimização dos recursos computacionais existentes. O laboratório possui servidores legados que, embora ociosos e antigos, mantêm capacidade computacional relevante. A proposta deste trabalho é a criação de uma nuvem privada utilizando essa infraestrutura subutilizada. Tal iniciativa visa desenvolver um ambiente dinâmico, seguro e escalável, que fornecerá estações de trabalho virtuais e isoladas para cada aluno, garantindo a continuidade das pesquisas do Lab Telecom.

### 3.2. Recursos Disponíveis

A solução proposta será implementada utilizando a infraestrutura de hardware existente e subutilizada no laboratório da UnB. Os recursos disponíveis consistem em 10 servidores Dell antigos, mas capazes de atender as necessidades de virtualização e computação em nuvem. Os modelos de servidores, listados na tabela 4, incluem: PowerEdge 2950, PowerEdge 2900, PowerEdge 1950 e PowerEdge R900. Embora sejam modelos mais antigos, esses servidores possuem capacidade de processamento e memória RAM que, quando combinadas e virtualizadas, podem oferecer um ambiente robusto para as simulações exigidas.

Tabela 4: Modelos de Servidores Disponíveis
| Modelo | Processador | Memória RAM | Armazenamento | 
| --- | --- | --- | --- |
| PowerEdge 2950 | Intel Xeon E5-2650 v3 | 24 GB | 4 TB |
| PowerEdge 2900 | Intel Xeon E5-2650 v3 | 64 GB | 1.088 TB |
| PowerEdge 1950 | Intel Xeon E5-2650 v3 | 64 GB | 256 GB |
| PowerEdge R900 | Intel Xeon E5-2650 v3 | 64 GB | 256 GB |
| PowerEdge 2900 | Intel Xeon E5-2650 v3 | 64 GB | 256 GB |

Além dos servidores, o laboratório dispõe de QUANTIDADE switches Cisco MODELO com cabos Gigabit, que serão utilizados para a interconexão da infraestrutura de rede da nuvem privada. Para garantir a integridade e a disponibilidade dos dados, será implementada uma configuração de RAID 6 em todos os servidores, proporcionando alta tolerância a falhas e segurança de dados, caso um disco venha a falhar.

**Sugestão de Imagens/Figuras:**
*   **Figura 3.2:** Fotos dos servidores Dell (se disponíveis e permitido) ou um diagrama esquemático que represente os modelos de servidores utilizados.
*   **Figura 3.3:** Diagrama da topologia de rede do laboratório, mostrando a interconexão dos servidores e switches.


### 3.3. Arquitetura da Nuvem Privada Dinâmica

A arquitetura da nuvem privada proposta é projetada para maximizar a utilização dos recursos de hardware existentes no laboratório da UnB, ao mesmo tempo em que oferece um ambiente flexível e escalável para os usuários. A estrutura da nuvem será organizada em camadas, garantindo a separação lógica e a modularidade dos componentes, conforme ilustrado na Figura 3.4.

Na base da arquitetura, encontram-se os **servidores físicos** Dell, que atuarão como nós de computação e armazenamento. Sobre esses servidores, será implementada a camada de **virtualização**, utilizando o KVM (Kernel-based Virtual Machine) em conjunto com o Ubuntu Server. A escolha do KVM é justificada por ser um sistema de código aberto, evitando o gasto com licenças de software proprietário, e dependencia tecnológica de empresas privadas. Além disso, ao compara-lo com o Xen, o KVM mostrou desempenho superior, maior facilidade de uso e de gerenciamento. Sua integração profunda com o kernel Linux, torna-o eficiente para ambientes de virtualização de alto desempenho. Como sistema operacional hospedeiro, será utilizado o Ubuntu Server, por ser uma plataforma estável e amplamente suportada para a execução do KVM e dos serviços do OpenStack.

A camada de **orquestração** será provida pelo OpenStack, que atuará como o sistema operacional da nuvem, gerenciando e coordenando todos os recursos computacionais, de rede e de armazenamento. Os principais componentes do OpenStack que farão parte dessa arquitetura incluem:

*   **Keystone (Serviço de Identidade):** Responsável pela autenticação e autorização de usuários e serviços, garantindo a segurança do acesso à nuvem;
*   **Nova (Serviço de Computação):** Gerenciará o ciclo de vida das máquinas virtuais, incluindo o provisionamento, agendamento e alocação de recursos;
*   **Neutron (Serviço de Rede):** Proverá a conectividade de rede para as VMs, permitindo a criação de redes virtuais isoladas para cada usuário ou grupo, além de roteamento e serviços de segurança;
*   **Cinder (Serviço de Armazenamento em Bloco):** Oferecerá volumes de armazenamento persistentes para as VMs, garantindo a integridade e a disponibilidade dos dados;
*   **Glance (Serviço de Imagem):** Gerenciará as imagens de máquinas virtuais, permitindo o armazenamento e a distribuição de imagens base para o rápido provisionamento de novas VMs;
*   **Horizon (Painel de Controle):** Fornecerá uma interface gráfica intuitiva para que os usuários e administradores possam interagir com a nuvem, gerenciar seus recursos e monitorar o ambiente.

Os usuários se conectarão às suas máquinas virtuais através de protocolos de acesso remoto, como SSH (\textit{Secure Shell}) para acesso via linha de comando ou RDP (\textit{Remote Desktop Protocol}) para acesso gráfico, garantindo que cada aluno tenha seu ambiente de trabalho isolado e personalizado. A escolha dessa arquitetura vem com o intuito de atender aos requisitos de provisionamento dinâmico, segurança dos dados, especialmente para trabalhos sigilosos que envolvem patentes, e o suporte a cargas de trabalho de alto desempenho, aproveitando a flexibilidade e a robustez do OpenStack em conjunto com a eficiência do KVM.

**Figura 5:** Diagrama de arquitetura da nuvem privada proposta, mostrando todas as camadas (física, virtualização, orquestração) e os principais componentes do OpenStack, com setas indicando o fluxo de comunicação e gerenciamento.


### 3.4. Implementação e Configuração

A implementação da nuvem privada dinâmica no laboratório da UnB seguirá uma abordagem faseada, garantindo a correta instalação e configuração de cada componente. Os passos detalhados para a implantação incluem:

1.  **Preparação dos Servidores Físicos:** Cada um dos servidores Dell (PowerEdge 2950, 2900, 1950, R900) será preparado com a instalação do sistema operacional Ubuntu Server. Durante a instalação, será configurado o RAID 6 para os discos de armazenamento, conforme justificado na seção 3.2, visando a redundância e a integridade dos dados. A escolha do Ubuntu Server se deve não só à sua robustez, mas também à sua vasta documentação, comunidade ativa e compatibilidade com o OpenStack e o KVM.

2.  **Instalação e Configuração do KVM:** Após a instalação do Ubuntu Server, o hipervisor KVM será instalado e configurado em cada servidor físico. O KVM será o responsável pela virtualização do hardware, permitindo a criação e execução das máquinas virtuais. A configuração do KVM incluirá a otimização de parâmetros para garantir o melhor desempenho possível para as cargas de trabalho intensivas.

3.  **Implantação do OpenStack:** A instalação dos serviços do OpenStack será realizada de forma distribuída, com os componentes de controle (Keystone, Glance, Nova API, Neutron Server, Cinder API) em um nó de controle, e os serviços de computação (Nova Compute) e armazenamento (Cinder Volume) distribuídos pelos demais servidores físicos. A configuração de cada serviço seguirá a documentação oficial do OpenStack para garantir a interoperabilidade e a eficiência:
    *   **Keystone:** será configurado para gerenciar a autenticação e autorização de todos os usuários e serviços da nuvem;
    *   **Glance:** será configurado para armazenar as imagens base das VMs, otimizando o provisionamento;
    *   **Nova:** será configurado para interagir com o KVM, gerenciando o ciclo de vida das VMs e a alocação de recursos;
    *   **Neutron:** será configurado para criar redes virtuais isoladas para cada usuário, além de roteamento e regras de segurança;
    *   **Cinder:** será configurado para provisionar volumes persistentes para as VMs, utilizando o armazenamento configurado com RAID 6 nos servidores físicos;
    *   **Horizon:** será instalado e configurado para fornecer uma interface gráfica para o gerenciamento da nuvem.

4.  **Configuração de Rede e Armazenamento:** A configuração de rede no Neutron incluirá a criação de redes virtuais para os usuários, sub-redes e roteadores virtuais. A integração do Cinder com o armazenamento físico dos servidores, configurado com RAID 6, garantirá a persistência e a segurança dos dados das VMs. A escolha dessas configurações visa otimizar o desempenho para aplicações de HPC e garantir a segurança dos dados sensíveis.

*   **Figura 6:** Capturas de tela (screenshots) de configurações importantes do OpenStack, como o painel do Horizon mostrando a criação de uma instância, ou a configuração de rede no Neutron, para ilustrar a interface de gerenciamento.


### 3.5. Provisionamento Dinâmico de Recursos 

O provisionamento dinâmico de recursos é um pilar fundamental da solução proposta, visando otimizar a utilização da memória RAM e do processamento (CPU) nos servidores físicos, garantindo que os recursos sejam alocados e redistribuídos de forma eficiente conforme a demanda dos usuários. Este mecanismo é crucial para ambientes com recursos limitados, como o laboratório da UnB, onde a flutuação na carga de trabalho é comum.

A implementação do provisionamento dinâmico será realizada através da integração de funcionalidades do OpenStack Nova e do hipervisor KVM. O `nova-scheduler`, componente do OpenStack Nova, desempenha um papel central ao determinar em qual host de computação uma nova máquina virtual (VM) deve ser provisionada, levando em consideração a disponibilidade de recursos e as políticas de alocação. No entanto, o provisionamento dinâmico em tempo de execução, ou seja, a redistribuição de recursos para VMs já em operação, será gerenciado por mecanismos do KVM e do sistema operacional subjacente.

Para a memória RAM, a técnica de **ballooning** será empregada. O ballooning permite que o hipervisor KVM "recupere" memória ociosa de VMs que não estão utilizando toda a sua RAM alocada e a disponibilize para outras VMs que necessitam de mais recursos. Isso é feito através de um driver de ballooning instalado dentro da VM, que se comunica com o hipervisor para ajustar dinamicamente a quantidade de memória disponível para a VM. Se uma VM está com pouca atividade, o driver de ballooning pode "inflar" (inflar o balão), fazendo com que o sistema operacional convidado libere memória para o hipervisor. Quando a VM precisa de mais memória, o balão é "desinflado", e a memória é devolvida. Essa abordagem garante que a memória seja utilizada de forma mais eficiente em todo o cluster (OPENSTACK, [s.d.]b; KUMAR; SINGH, 2016).

Para o processamento (CPU), o KVM, em conjunto com as configurações do Linux, permite a alocação dinâmica de núcleos de CPU e ciclos de processamento. Serão implementadas **políticas de fair-share** (compartilhamento justo) no nível do hipervisor, que garantem que o poder de processamento seja distribuído equitativamente entre as VMs, mas com a capacidade de priorizar VMs que demandam mais recursos em momentos de pico. Isso significa que, se um usuário estiver executando uma simulação intensiva em CPU e outro usuário estiver ocioso, os recursos não utilizados pelo segundo usuário poderão ser temporariamente alocados para o primeiro, otimizando o desempenho geral do sistema. Quando o segundo usuário retomar a atividade, os recursos serão redistribuídos conforme a necessidade.

Os algoritmos de decisão para a redistribuição de recursos serão baseados em métricas de uso de CPU e RAM coletadas em tempo real. Ferramentas de monitoramento integradas ao OpenStack e ao KVM (como Ceilometer ou Prometheus/Grafana) serão utilizadas para coletar esses dados. A lógica de decisão considerará:

*   **Uso atual de recursos:** VMs com alta utilização de CPU ou RAM terão prioridade na alocação de recursos adicionais.
*   **Recursos ociosos:** Recursos não utilizados por VMs ociosas serão identificados e disponibilizados para outras VMs.
*   **Políticas de prioridade:** Poderão ser definidas políticas para dar prioridade a determinados usuários ou tipos de carga de trabalho, caso necessário.

A eficácia dessa abordagem reside na capacidade de maximizar o aproveitamento dos servidores antigos, transformando-os em uma infraestrutura flexível que se adapta às necessidades dos usuários, sem a necessidade de intervenção manual constante. Isso garante uma melhor qualidade de serviço para os alunos, mesmo com a limitação de hardware, e otimiza o investimento em infraestrutura.


*   **Figura 7:** Fluxograma detalhado do processo de provisionamento dinâmico de recursos, ilustrando como o `nova-scheduler` e os mecanismos de `ballooning` e `fair-share` interagem para alocar e redistribuir CPU e RAM.
*   **Figura 8:** Gráfico de monitoramento de uso de CPU/RAM em VMs ao longo do tempo, demonstrando a alocação dinâmica de recursos em resposta a picos de demanda e ociosidade.



### 3.6. Gerenciamento de Imagens de Máquinas Virtuais (Virtual Machine Image Management)

O gerenciamento eficiente de imagens de máquinas virtuais (VMs) é fundamental para a agilidade no provisionamento e para a padronização dos ambientes de trabalho no laboratório. A solução proposta utilizará o serviço Glance do OpenStack para criar, armazenar e distribuir as imagens base (base images) das VMs (OPENSTACK, [s.d.]e).

As **imagens base** serão configuradas com os sistemas operacionais e softwares essenciais para as atividades do laboratório, como as ferramentas de simulação (Ansys, SolidWorks, Cadence). Isso garante que cada nova VM provisionada inicie com um ambiente pré-configurado e pronto para uso, reduzindo o tempo de setup para os usuários.

Para garantir a persistência das alterações realizadas pelos usuários em suas VMs, serão empregadas duas abordagens principais:

1.  **Discos Diferenciais:** Ao provisionar uma nova VM a partir de uma imagem base, um disco diferencial (também conhecido como *overlay* ou *copy-on-write*) será criado. Este disco armazenará apenas as alterações feitas pelo usuário na VM, enquanto a imagem base permanece inalterada. Essa técnica otimiza o espaço de armazenamento, pois múltiplas VMs podem compartilhar a mesma imagem base, e facilita a restauração da VM para um estado inicial, se necessário.

2.  **Volumes Cinder Anexados:** Para dados mais críticos e que exigem maior persistência e flexibilidade, os usuários poderão anexar volumes de armazenamento persistentes providos pelo serviço Cinder. Esses volumes são independentes do ciclo de vida da VM e podem ser desanexados e reanexados a outras VMs, garantindo que os dados do usuário permaneçam seguros mesmo que a VM seja excluída ou recriada.

O processo de gerenciamento de imagens permitirá que os administradores do laboratório criem e atualizem as imagens base de forma centralizada, garantindo que todos os usuários tenham acesso às versões mais recentes dos softwares e configurações. Além disso, a capacidade de restaurar uma VM para seu estado original a partir da imagem base, ou de preservar dados em volumes Cinder, oferece flexibilidade e segurança para os usuários, que podem experimentar e desenvolver seus projetos sem o risco de perder informações importantes.

*   **Figura 9:** Diagrama do ciclo de vida de uma imagem de VM e seus discos associados, ilustrando a relação entre a imagem base, o disco diferencial e os volumes Cinder anexados.


### 3.7. Políticas de Escalonamento

Para garantir que a nuvem privada se adapte dinamicamente às flutuações de demanda dos usuários do laboratório, serão implementadas políticas de escalonamento automático (autoscaling). O escalonamento automático permite que a infraestrutura da nuvem responda proativamente às mudanças na carga de trabalho, aumentando ou diminuindo os recursos disponíveis sem a necessidade de intervenção manual. Isso é particularmente importante em um ambiente acadêmico, onde o número de usuários e a intensidade das cargas de trabalho podem variar significativamente ao longo do dia ou do semestre.

As políticas de escalonamento serão baseadas em métricas de desempenho coletadas em tempo real, como o uso de CPU e memória RAM das máquinas virtuais e dos hosts físicos. Os gatilhos (triggers) para o escalonamento serão definidos com base em limiares (thresholds) predefinidos para essas métricas. Por exemplo, se o uso médio de CPU de um conjunto de VMs exceder um determinado percentual por um período contínuo, uma ação de escalonamento será acionada.

As ações de escalonamento podem incluir:

*   **Escalonamento Vertical:** Aumento ou diminuição dos recursos (CPU, RAM) alocados a uma VM existente. Isso pode ser feito através de ajustes dinâmicos de recursos suportados pelo KVM e gerenciados pelo OpenStack Nova, complementando o provisionamento dinâmico detalhado na seção 3.5.
*   **Escalonamento Horizontal:** Início de novas VMs a partir de imagens base pré-configuradas para distribuir a carga de trabalho, ou a parada de VMs ociosas para liberar recursos. Embora o foco principal seja o provisionamento dinâmico de recursos *dentro* das VMs, a capacidade de iniciar novas VMs sob demanda é uma extensão natural para lidar com um aumento significativo no número de usuários ou na demanda total.

A necessidade de automatizar o gerenciamento de recursos é justificada pela complexidade de monitorar e ajustar manualmente uma infraestrutura de nuvem em constante mudança. As políticas de escalonamento garantem a eficiência operacional, a disponibilidade dos recursos e a qualidade de serviço para os usuários, otimizando o uso dos servidores antigos e prolongando sua vida útil. A implementação dessas políticas contribuirá para um ambiente de HPC mais responsivo e adaptável às necessidades do laboratório.

*   **Figura 10:** Exemplo de política de escalonamento baseada em uso de CPU, mostrando um gráfico de uso de CPU ao longo do tempo com os limiares de escalonamento (aumentar/diminuir) e as ações correspondentes.


### 3.8. Escalabilidade e Automatização de Configurações
- ansible
- terraform
- como adicionar mais servidores
