# Fundamentação Teórica

Este capítulo reúne a fundamentação teórica necessária, cobrindo conceitos de computação em nuvem, virtualização, nuvens privadas, arquitetura do OpenStack e princípios de elasticidade e provisionamento dinâmico de recursos.

## Computação em Nuvem (*Cloud Computing*)

### Definição e Paradigma

A computação em nuvem (*cloud computing*) é definida na publicação especial 800-145 pelo *National Institute of Standards and Technology* (NIST) como um modelo que permite acesso a um conjunto compartilhado de recursos computacionais configuráveis — redes, servidores, armazenamento, aplicações e serviços — sob demanda e via rede. Esses recursos podem ser rapidamente provisionados e liberados com mínimo esforço de gerenciamento ou interação com o provedor de serviços [@mell2011]. Essa definição enfatiza cinco características essenciais:

- **Autoatendimento sob demanda (*On-demand self-service*)** – o próprio usuário pode provisionar recursos, como tempo de CPU ou armazenamento, sempre que necessário, sem intervenção humana junto ao provedor [@mell2011].
- **Acesso amplo à rede (*Broad network access*)** – os serviços são acessíveis via Internet por meio de mecanismos padronizados, compatíveis com múltiplos dispositivos [@mell2011].
- **Agrupamento de recursos (*Resource pooling*)** – processamento, memória, armazenamento e largura de banda são agrupados e redistribuídos dinamicamente entre múltiplos inquilinos (*multi-tenant*) conforme a demanda [@mell2011].
- **Elasticidade rápida (*Rapid elasticity*)** – a capacidade de hardware aparenta ser ilimitada, podendo aumentar ou diminuir de forma ágil — muitas vezes automática — para acompanhar variações de carga [@mell2011].
- **Serviço mensurado (*Measured service*)** – o uso de recursos é monitorado, controlado e relatado, garantindo transparência ao provedor e ao consumidor [@mell2011].

### Modelos de Serviço

Com base nessas características, o NIST classifica os serviços em três modelos:

- **Software como Serviço (SaaS)** – oferece aplicações completas hospedadas na nuvem e acessadas pela Internet. O usuário não gerencia a infraestrutura subjacente [@mell2011].
- **Plataforma como Serviço (PaaS)** – provê um ambiente na nuvem para que o consumidor implante aplicações próprias, sem administrar servidores, rede ou sistemas operacionais [@mell2011].
- **Infraestrutura como Serviço (IaaS)** – disponibiliza recursos fundamentais (processamento, armazenamento e rede), permitindo ao usuário instalar sistemas operacionais e aplicações com controle limitado de rede [@mell2011].

### Modelos de Implantação

A implantação de sistemas de computação em nuvem pode ser realizada por meio de diferentes modelos, cada qual adequado a contextos específicos [@mell2011]:

- **Nuvem Pública (*Public cloud*)** – infraestrutura operada por provedores terceirizados e disponibilizada pela Internet. Oferece alta escalabilidade e custos iniciais menores, mas menor controle sobre segurança [@carroll2011; @amajuoyi2024; @sathya2023].
- **Nuvem Privada (*Private cloud*)** – infraestrutura dedicada a uma única organização, podendo estar on-premises ou em data centers de terceiros. Garante maior controle, personalização e segurança [@swapna2023].
- **Nuvem Comunitária (*Community cloud*)** – infraestrutura compartilhada por organizações com interesses ou requisitos comuns (por exemplo, regulatórios) [@mell2011].
- **Nuvem Híbrida (*Hybrid cloud*)** – combinação de duas ou mais infraestruturas (pública, privada ou comunitária), permitindo portabilidade de dados e aplicações [@mell2011].

## Virtualização e Hipervisores

A virtualização abstrai o hardware de máquinas físicas, agrupando logicamente seus recursos em *pools* que permitem a criação de máquinas virtuais (VMs) isoladas em um único host físico [@carissimi2008; @kominos2017]. Essa técnica fundamenta pilares da computação em nuvem como elasticidade, multilocação e eficiência de custos [@chawla2025].

O componente responsável por criar e gerenciar VMs é o **hipervisor** (*Virtual Machine Monitor* – VMM) [@carissimi2008]. Ele se posiciona entre o hardware e os sistemas operacionais convidado, orquestrando o acesso aos recursos físicos e mantendo isolamento entre VMs. Há dois tipos principais:

- **Tipo 1 (*Bare-metal*)** – executa diretamente sobre o hardware do servidor (ex.: Xen, VMware ESXi, Microsoft Hyper-V) e tende a oferecer maior desempenho e segurança [@chawla2025].
- **Tipo 2 (*Hosted*)** – opera como aplicação sobre um sistema operacional hospedeiro (ex.: KVM, Oracle VirtualBox, VMware Player), sendo mais simples de instalar porém com alguma sobrecarga [@chawla2025].

### Tipos de Virtualização

A virtualização de sistema pode ser implementada principalmente de duas formas [@carissimi2008]:

- **Virtualização total** – a VM executa instruções não-privilegiadas diretamente e as privilegiadas são trap-e-emuladas pelo hipervisor.
- **Paravirtualização** – o sistema operacional convidado é modificado para comunicar-se diretamente com o hipervisor por meio de *hypercalls*.

### KVM como Solução de Hipervisor

O **Kernel-based Virtual Machine (KVM)** integra um hipervisor ao kernel Linux. Embora classificado como Tipo 2, sua integração ao kernel proporciona desempenho próximo a soluções Tipo 1, tirando proveito de extensões de virtualização de hardware (Intel VT-x, AMD-V) [@anand2013; @chawla2025].

## Máquinas Virtuais & Imagens

## OpenStack

### Definição e Características

O *OpenStack* é uma plataforma de código aberto para implantação de nuvens IaaS, criada em 2010 pela união da Rackspace e da NASA [@nasa2012]. Sua arquitetura modular permite escolher apenas os componentes necessários (Nova, Swift, Neutron, etc.) e personalizar a infraestrutura, o que, aliado à ausência de custos de licença, torna-o atraente a data centers, provedores de telecomunicações e instituições de pesquisa [@grzonka2015; @rousseau2019].

### Módulos Básicos do OpenStack

- **Keystone – Serviço de Identidade**: autenticação, autorização e catálogo de serviços [@openstack2025].
- **Nova – Serviço de Computação**: provisionamento e gerenciamento do ciclo de vida de instâncias virtuais.
- **Neutron – Serviço de Rede**: conectividade de rede, SDN, FWaaS e LBaaS [@openstack2025].
- **Horizon – Dashboard**: interface gráfica para gerenciamento de recursos.
- **Glance – Serviço de Imagem**: registro e entrega de imagens de disco de VMs [@openstack2024].
- **Cinder – Armazenamento em Bloco**: volumes persistentes, *snapshots* e *backups* [@openstack2021].
- **Swift – Armazenamento de Objetos**: armazenamento de objetos altamente disponível e escalável [@openstack2023].

## Elasticidade e Provisionamento Dinâmico

### Dimensionamento automático

(*Conteúdo a ser desenvolvido*)

### Políticas *Fair-Share* e *Ballooning*

(*Conteúdo a ser desenvolvido*)

## Imagens Base Compartilhadas

(*Conteúdo a ser desenvolvido*)

## Trabalhos Relacionados

(*Conteúdo a ser desenvolvido*)

## Síntese dos Conceitos

(*Conteúdo a ser desenvolvido*)