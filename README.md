# Jackpot - Título de Capitalização ⚽💰

Aplicativo mobile com temática de futebol para compra de títulos de capitalização no modelo **Jackpot**.  
Implementado com **Flutter** seguindo princípios de **Clean Code** e **SOLID**, com arquitetura modular e escalável.

---
## Badges

![Flutter](https://img.shields.io/badge/Flutter-3.35.0-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.7-blue?logo=dart)  ![Clean Architecture](https://img.shields.io/badge/Architecture-Clean%20Arch-brightgreen)
![SOLID](https://img.shields.io/badge/Principles-SOLID-orange) ![Provider](https://img.shields.io/badge/State-Provider-purple) ![PagSeguro](https://img.shields.io/badge/API-PagSeguro-yellowgreen)

---

## 📑 Sumário
- [Visão Geral](#visão-geral)  
- [Arquitetura](#arquitetura)
- [Principais Tecnologias](#principais-tecnologias)
- [Princípios Aplicados](#princípios-aplicados)
- [Gerenciamento de Estado e Injeção de Dependências](#gerenciamento-de-estado-e-injeção-de-dependências)
- [Integração com API PagSeguro](#integração-com-api-pagseguro)
- [Pagamentos Suportados](#pagamentos-suportados)
- [Boas Práticas de Código](#boas-práticas-de-código)
- [Como Rodar o Projeto](#como-rodar-o-projeto)
- [Demonstrações / Screenshots](#demonstrações--screenshots)  
- [Roadmap & Melhorias Futuras](#roadmap--melhorias-futuras)  
- [Autor / Contato](#autor--contato)

---

## Visão Geral

- Projeto construído com Flutter para mobile, com suporte a múltiplos formatos de produto: imagem simples, carrossel, vídeo.  
- Autenticação com backend + biblioteca do Google para captura facial.  
- Integrações de backend / API RESTful para listagem de jogos, apostas, criação e recuperação de apostas, login, logout.  
- Pagamento via Pix e cartão.  

## 🏗️ Arquitetura
O projeto segue uma arquitetura limpa e modular baseada na **Clean Architecture**, com as seguintes camadas:

- **Domain** → Entidades e casos de uso (regras de negócio).  
- **Data** → Repositórios e data sources (API PagSeguro).  
- **Presentation** → Telas (UI) e gerenciadores de estado (Provider).  

---

## ⚙️ Principais Tecnologias
- Flutter 3.35.0
- Provider (gerenciamento de estado e injeção de dependências)  
- Integração com API PagSeguro  
- Suporte a  pagammento via Pix e Cartão de Crédito  

---

## 📐 Princípios Aplicados
- **Clean Code** → Nomes descritivos, funções pequenas, legibilidade.  
- **SOLID**  
  - **S**ingle Responsibility → Cada classe tem uma única responsabilidade.  
  - **O**pen/Closed → Código aberto para extensão e fechado para modificação.  
  - **L**iskov Substitution → Abstrações permitem substituição sem quebrar o sistema.  
  - **I**nterface Segregation → Interfaces enxutas e específicas.  
  - **D**ependency Inversion → Camadas dependem de abstrações, não de implementações.  
- **Separation of Concerns** → Camadas desacopladas (UI, lógica de negócio, dados).  
- **Dependency Injection** (com Provider) → Facilita testabilidade e manutenção.  
- **Repository Pattern** → Abstração do acesso a dados da API.  
- **Error Handling & Result Types** → Uso de objetos de resultado para tratar sucessos e falhas de forma consistente.  

---

## 🧩 Gerenciamento de Estado e Injeção de Dependências
Foi utilizado o **Provider** tanto para gerenciamento de estado quanto para injeção de dependências.  
Esse padrão permitiu centralizar a lógica e facilitar testes unitários e integração.  

---

## 🔗 Integração com API PagSeguro
O app consome endpoints da **PagSeguro API** para realizar operações financeiras de forma segura:

- Criação de pedidos de pagamento  
- Integração com **PIX**  
- Integração com **Cartão de Crédito**  
- Validação de transações  

---

## 💳 Pagamentos Suportados
- ✅ Pix  
- ✅ Cartão de Crédito  

---

## 🛠️ Boas Práticas de Código
- Versionamento seguindo **GitFlow**  
- **Commits semânticos**  
- Arquitetura limpa e desacoplada  
- Tratamento centralizado de erros  
- Código escalável e testável  

---

## Instalação & Configuração

1. Clone o repositório  
2. Instale dependências: `flutter pub get`  
3. Defina variáveis de ambiente (ex: chave do serviço de verificação facial, endpoints backend)  
4. Rodar localmente: `flutter run`  

---

## ▶️ Como Rodar o Projeto
1. Clone o repositório
```bash
git clone https://github.com/seuuser/jackpot.git
````

---

## Demonstrações / Screenshots

*(inserir imagens ou GIFs mostrando telas relevantes, carrosséis, vídeo, fluxo de pagamento, etc.)*

---

## Roadmap & Melhorias Futuras
- Testes unitários para regras de negócio  
- Testes de widget para componentes UI  
- Testes de integração para fluxo completo (autenticação, aposta, pagamento) 
- Automatização CI/CD para builds automáticos  
- Melhoria de cobertura de código  
- Monitoramento de erros (ex: Crashlytics)  
- Monitoramento do comportaento do usuário (ex: Analytics)

---

## Autor / Contato

- Pedro Camargo
- [LinkedIn](https://www.linkedin.com/in/pedro-kamargo/)  
- [Portfólio / GitHub](https://github.com/P3edr0)

---

## Licença

Este projeto está licenciado sob a MIT License.  





