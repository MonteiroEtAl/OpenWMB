# OpenWMB: an open-source and automated working memory task battery for OpenSesame.

This page contains an open-source and automated battery of working memory (WM) tasks that tap into different functional aspects of working memory — simultaneous storage and processing of information, continuous updating of mental representations, and binding of information elements into structures.

## Features 
- The instrument includes three complex spans (reading span, operation span, and symmetry span), two updating tasks (n-back task and memory updating task), and two binding tasks (binding and maintenance task and multimodal span).<sup>*</sup>
- The OpenWMB was entirely programmed in [OpenSesame](http://osdoc.cogsci.nl/), using Python and OpenSesame scripting.
- The battery possesses flexible features that can be implemented without any programming knowledge. For instance, users can choose to only administrate a portion of the tasks or a single task. 
- The OpenWMB is suitable for group testing, is entirely computer-paced, has embedded instructions for each task, and has automatic scoring. 
- The order of presentation of the tasks is automatically counterbalanced between-participants (on complete administrations).
- It includes a data processing script that converts all data collected into an easily interpretable format that is ready for data analysis (in platforms like R or SPSS).
- The OpenWMB is available in Portuguese and English — however, we only assessed the psychometric properties of the former version. The raw data collected for this study and the imputed databases used to estimate the psychometric properties of the Portuguese version are stored in the files named "Raw_Data_Validation_PT_version.xlsx" and "Imputed_Databases_Validation_PT_version.xlsx", respectively. 

<sub> * The English version of the battery does not include the reading span.</sub>

## Learning how to download, install and run the OpenWMB, and how to analyze and interpret data collected with the battery 
This repository contains four folders with different versions of the battery (OpenWMB_EN_macOS.zip, OpenWMB_EN_Windows.zip, OpenWMB_PT_macOS.zip, and OpenWMB_PT_Windows.zip). Each of these folders includes the “.osexp” file that runs the OpenWMB, a data-processing script named “Script_Organize_log_files.py”, and two plugins that are required to run the battery (mousetrap_form and mousetrap_response). They also hold several documents with tutorials and examples that explain in detail how to install and run the OpenWMB, and how to analyze and interpret data collected with the battery. 

To install and use the OpenWMB, you first need to download the folder containing the version of the battery that is compatible with your operating system (Windows or macOS) and fulfills your language requirements — Portuguese (PT) or English (EN). To do this, left-click on the folder that you intend to download. Next, left-click on the option “View raw” to download OpenWMB. When the download is completed, unzip the OpenWMB folder and paste it on your desktop. Open the main folder of the battery and read the file called “IMP_what_is_in_this_folder” to get acquainted with the contents of the OpenWMB. Next, open the subfolder called “Tutorials” and read the installation, user, and interpretation guides to learn how to install and use the battery and how to interpret data collected and processed by the scripts included in the battery. This subfolder also holds an Excel file named “Example_BD_WM_Battery”. This file contains a simulated database that exemplifies how data collected with the OpenWMB is organized after it has been processed with the script "Script_Organize_log_files.py" (this script transforms data collected with the OpenWMB in an easily interpretable format).
It is important to consult these files thoroughly to learn how to run the battery and comprehend all its features. The tutorials should be consulted in the following order:

1 - Instalation_Guide

2 - Users_Guide 

3 – Interpretation_Guide 

4 - Example_BD_WM_Battery 

5 - interpret_loggers


## Compatibility
The OpenWMB is compatible with Microsoft Windows (Vista or above) and Apple macOS (the battery was tested in macOS Ventura, version 13.2.1). 

## Recommendations
We recommend using a mouse to administrate the battery, especially if you intend to employ the multimodal and/or the symmetry span. 

## Publications
- Soon, we will publish a scientific paper that will report a validation study and describe the features of the OpenWMB in detail. We kindly ask that you cite this work if you use the battery in published research. 
- The OpenWMB runs on [OpenSesame](http://osdoc.cogsci.nl/) and uses the [MouseTrap](https://github.com/PascalKieslich/mousetrap-os) plugin. Both software are open-source. If you use our battery, we kindly ask that you also cite these tools, as we would not be able to program and run the battery without them.

## Contacts
If you have any questions or suggestions regarding the battery or future studies, you can forward them to the e-mail address uc2021194081@student.uc.pt.

---

# OpenWMB: uma bateria _open-source_ e automatizada de tarefas de memória de trabalho para o OpenSesame. 
Esta página contém uma bateria _open-source_ e automatizada de tarefas de memória de trabalho que avaliam diferentes aspetos funcionais da memória de trabalho — capacidade de armazenar e processar informação de forma simultânea, atualização contínua de representações mentais, capacidade de vincular diferentes características de estímulos e criar novas estruturas relacionais.

## Características 
- O instrumento inclui três complex spans (reading span, operation span e symmetry span), duas updating tasks (n-back task e memory updating task), e duas binding tasks (binding and maintenance task e multimodal span).<sup> * </sup>   
- A OpenWMB foi completamente programada em [OpenSesame](http://osdoc.cogsci.nl/), utilizando a linguagem de programação Python e a linguagem de _scripting_ do OpenSesame.
- A bateria possui algumas características flexíveis que podem ser implementadas sem nenhum conhecimento de programação. Por exemplo, os utilizadores podem administrar apenas uma parte das tarefas ou até uma só prova.
- A OpenWMB pode ser administrada de forma simultânea a vários participantes, é completamente automatizada, possui instruções integradas para cada uma das tarefas e cota automaticamente os resultados dos participantes em cada uma das provas. 
- A ordem de apresentação das tarefas é contrabalanceada automaticamente entre participantes (em administrações completas).
- A bateria inclui um script de pré-processamento de dados que converte os dados recolhidos num formato facilmente interpretável e pronto para a análise de dados em plataformas como o R e o SPSS.
- A OpenWMB está disponível em Português e Inglês — porém, só avaliámos as propriedades psicométricas da versão portuguesa. Os dados brutos recolhidos durante este estudo e as bases de dados imputadas que foram utilizadas para estimar as propriedades psicométricas da versão portuguesa estão armazenados nos ficheiros intitulados "Raw_Data_Validation_PT_version.xlsx" e "Imputed_Databases_Validation_PT_version.xlsx", respectivamente.

<sub> * A versão inglesa da bateria não inclui o reading span. </sub> 

## Aprender a descarregar, instalar e utilizar a OpenWMB e analizar e interpretar os dados recolhidos com esta bateria
Este repositório contém quatro pastas com diferentes versões da bateria (OpenWMB_EN_macOS.zip, OpenWMB_EN_Windows.zip, OpenWMB_PT_macOS.zip, e OpenWMB_PT_Windows.zip). Cada uma destas pastas inclui um ficheiro “.osexp” que contém a OpenWMB, um script de processamento de dados intitulado “Script_Organize_log_files.py” e dois plugins que são necessários para o bom funcionamento da bateria (mousetrap_form e mousetrap_response). Estas pastas também integram vários documentos com tutoriais e exemplos que explicam em detalhe como instalar e utilizar a OpenWMB e como processar e interpretar os dados recolhidos com este instrumento.

Para instalar e utilizar a OpenWMB, deverá começar por descarregar a pasta que contém a versão da bateria que é compatível com o seu sistema operativo (Windows ou macOS) e que cumpre os seus requisitos de linguagem — português (PT) ou inglês (EN). Para isso deve pressionar a pasta que contém a versão da bateria que pretende descarregar com o botão esquerdo do rato. De seguida, clique com o botão esquerdo do rato na opção “View raw” para descarregar a OpenWMB. Quando o download terminar, deve descompactar a pasta que contém a OpenWMB e movê-la para o seu ambiente de trabalho. Abra a pasta principal da OpenWMB e leia o ficheiro intitulado “IMP_o_que_contem_esta_pasta” para se familiarizar com os conteúdos do instrumento. A seguir, abra a subpasta “Tutoriais” e leia os guias de instalação, de utilizador e de interpretação para aprender a instalar e utilizar a bateria e saber como deve analisar e interpretar os dados recolhidos e processados pelos scripts incluídos na bateria. A subpasta “Tutoriais” também inclui um ficheiro Excel intitulado “Example_BD_WM_Battery”. Este contém uma base de dados simulada que exemplifica como é que os dados recolhidos com a OpenWMB ficam organizados depois de serem processados pelo script "Script_Organize_log_files.py" (este script converte os dados recolhidos pela OpenWMB num formato facilmente interpretável). É muito importante consultar estes ficheiros para aprender a utilizar a bateria e compreender todas as suas funções. Estes devem ser consultados na seguinte ordem:

1 - Intrucoes_Instalacao

2 - Instrucoes_Utilizacao

3 – Instrucoes_Interpretacao

4 - Exemplo_BD_WM_Battery

5 - interpret_loggers


## Compatibilidade
A OpenWMB é compatível com o Microsoft Windows (Vista ou versões mais recentes) e Apple macOS (a bateria foi testada no macOS Ventura, version 13.2.1).

## Recomendações
Recomendamos que utilize um rato durante a administração da bateria, principalmente se pretende utilizar o multimodal span e/ou o symmetry span. 

## Publicações
- Brevemente iremos publicar um artigo científico no qual iremos reportar um estudo de validação e descrever as características da OpenWMB em detalhe. Caso utilize este instrumento em qualquer trabalho publicado pedimos encarecidamente que cite este artigo.
- A OpenWMB necessita do [OpenSesame](http://osdoc.cogsci.nl/) e do plugin [MouseTrap](https://github.com/PascalKieslich/mousetrap-os) para funcionar corretamente. Ambos os softwares são _open-source_. Se utilizar a bateria pedimos que também cite estes dois trabalhos.

## Contactos
Se tiver alguma questão ou sugestão relacionados com a bateria ou estudos futuros pode encaminhá-las através do endereço de e-mail uc2021194081@student.uc.pt.
