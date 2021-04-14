<h1>Anotações Rápidas com SQFlite</h1> 

<p align="center">
  <img src="https://img.shields.io/static/v1?label=dart&message=language&color=blue&style=for-the-badge&logo=DART"/>  
  <img src="https://img.shields.io/static/v1?label=flutter&message=framework&color=blue&style=for-the-badge&logo=FLUTTER"/>  
  <img src="http://img.shields.io/static/v1?label=License&message=MIT&color=green&style=for-the-badge"/>   
  <img src="http://img.shields.io/static/v1?label=TESTES&message=%3E100&color=GREEN&style=for-the-badge"/>  
   <img src="http://img.shields.io/static/v1?label=STATUS&message=CONCLUIDO&color=GREEN&style=for-the-badge"/>   
</p>

> Status do Projeto: :heavy_check_mark: (concluido)
---

### 📖 Tópicos 

:small_blue_diamond: [Descrição do projeto](#-descrição-do-projeto)

:small_blue_diamond: [Funcionalidades](#-funcionalidades)

:small_blue_diamond: [Layout da Aplicação](#-layout)

:small_blue_diamond: [Pré-requisitos](#-pré-requisitos)

:small_blue_diamond: [Como execultar a aplicação](#-como-execultar-a-aplicação)

:small_blue_diamond: [Casos de uso](#-casos-de-uso)

:small_blue_diamond: [Linguagens, dependencias e libs utilizadas](#-linguagens-dependencias-e-libs-utilizadas)

:small_blue_diamond: [Autor](#-autor)

--- 

## 💻 Descrição do projeto 

<p align="justify">
  Projeto realizado em Flutter, referente a salvar algumas anotações rápidas, utilizando o banco de dados local SQFlite e alguns conceitos de animação. 
</p>

---

## ⚙️ Funcionalidades

:heavy_check_mark: Abre diretamente na tela Home.  
  
:heavy_check_mark: Tela Home, com a opção de incluir, atualizar e ou excluir uma anotação.  

:heavy_check_mark: O botão flutuante possui uma animação onde é possivel não somente realizar uma anotação como também salvar um audio ou imagem.  

:heavy_check_mark: persistência de dados com SQFlite. 

---

## 🎨 Layout 

<p align="center">
  <img alt="Home" title="#Home" src="https://user-images.githubusercontent.com/77983152/107226772-4a583500-69f9-11eb-87b5-63924a994f4f.png" width="200px">

  <img alt="Add" title="#Add" src="https://user-images.githubusercontent.com/77983152/107226918-7ffd1e00-69f9-11eb-8dba-2d2afd3fe201.png" width="200px">

  <img alt="Tabline" title="#Tabline" src="https://user-images.githubusercontent.com/77983152/107229330-732df980-69fc-11eb-89d2-822ed6fba2b8.png" width="200px">

  <img alt="floatactionbutton" title="#floatactionbutton" src="https://user-images.githubusercontent.com/77983152/114714362-6ed9d180-9d08-11eb-8401-34d2e442a58a.png" width="200px"> 
</p>

---

## 🎯 Pré-requisitos

:warning: [Flutter](https://flutter.dev/docs/get-started/install)

:warning: [Android Studio](https://developer.android.com/studio)

:warning: [Vscode](https://code.visualstudio.com/download)

---

## ▶️ Como execultar a aplicação

No terminal, clone o projeto: 

```
git clone https://github.com/AndersonD-art/my_notes.git
```
---

## 📌 Casos de uso

💬 Trata-se de um organizador de notas rápitas, que utiliza o banco de dados SQFlite para a persistencia de dados, podendo ser salvo notas em texto, audio ou imagem.

💬 Logo de inicio já ira surgir a tela home, onde é possivel visualizar as notas caso já tenha adicionado alguma. Caso não tenha nenhuma nota ira surgir no centro do app, uma mensagem informando 'Nenhuma tarefa'. Para adicionar uma tarefa é realmente muito simples, basta acionar o botão flutuante '+', após irar surgir três novos botões flutuantes um de 'anotação' que ao acionar ira surgir um showdialog solicitando que informe um título e uma descrição para esta nova tarefa, ao final basta clicar em salvar para concluir a operação ou cancelar caso não deseja prosseguir com o cadastro da nota. Os outros dois botões fluantes de 'audio' e 'imagem' ainda se encontra em fase de testes.

💬 Após o cadastro das notas, será possivel observar o título e a descrição da mesma em sua tabline, e ao final da nota existe dois icones, um para realizar a edição ou atualização da nota representada com o 'lapis' e um outro para realizar a exclusão da nota, representada por uma 'lixeira'.

---

## 🛠 Linguagens, dependencias e libs utilizadas

- [Lab: Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

---

## 🎓 Autor

 <img style="border-radius: 50%;" src="https://avatars.githubusercontent.com/u/77983152?s=460&u=f61c18670116cb318cdf26e7523643a6dccb5680&v=4" width="100px;" alt=""/>
 <br />
 <sub><b>Anderson David</b></sub> ☕
 <br />

[![Linkedin Badge](https://img.shields.io/badge/-AndersonDavid-blue?style=flat-square&logo=Linkedin&logoColor=white&link=https://www.linkedin.com/in/anderson-david-ti)](https://www.linkedin.com/in/anderson-david-ti) 
[![Hotmail Badge](https://img.shields.io/badge/-andersondavidti@hotmail.com-c14438?style=flat-square&logo=Hotmail&logoColor=white&link=mailto:andersondavidti@hotmail.com)](mailto:andersondavidti@hotmail.com)

---

## 📝 Licença 

The [MIT License](https://github.com/AndersonD-art/my_notes/commit/35c9075d739ff16ac14b7b0a8850c2489014c3e0)(MIT)

Copyright :copyright: 2021 - My Notes