# Mini Instagram Clone

Clone da interface inicial do Instagram desenvolvido em Flutter, incluindo Stories animados e feed de posts.  
O objetivo é praticar desenvolvimento mobile, UI/UX e organização de projeto.

---

## Funcionalidades
- Stories animados com gradiente giratório, incluindo "Seu story"
- Feed com cards de posts (avatar, nome, imagem, ações)
- Foto de perfil no canto esquerdo de cada post
- Barra inferior de navegação fixa
- Interface responsiva usando Device Preview

---

## Tecnologias e Técnicas Utilizadas
- Flutter e Dart
- Widgets avançados: `ListView.builder`, `Stack`, `CircleAvatar`, `BottomNavigationBar`
- Layouts responsivos: `Expanded`, `Column`, `Row`, `SizedBox`
- Device Preview para testar em múltiplos dispositivos
- Boas práticas de UI/UX: alinhamento, tipografia e espaçamento
- Modularização futura possível, mantendo todo o código limpo e organizado

---

## Captura de Tela

*Coloque aqui seus prints do app, por exemplo:*

![Feed](assets/post1.jpg)
![Stories](assets/story.jpg)

---

## Como Rodar o Projeto

### 1. Clonar o repositório
```bash
git clone https://github.com/seu-usuario/instagram_clone.git
cd instagram_clone
````

### 2. Instalar dependências

```bash
flutter pub get
```

### 3. Executar no emulador ou dispositivo

```bash
flutter run
```

---

## Estrutura do Projeto

```
lib/
 └── main.dart                # Código principal com stories animados e feed
assets/
 ├── fonts/Billabong.ttf      # Fonte usada no app
 ├── post1.jpg
 ├── post4.jpg
 ├── post5.jpg
 └── story.jpg
pubspec.yaml                  # Dependências e configuração de assets/fonte
README.md                     # Documentação do projeto
```

---

## Contribuição

Contribuições são bem-vindas:

1. Faça um fork do projeto
2. Crie uma branch com sua feature: `git checkout -b minha-feature`
3. Commit suas alterações: `git commit -m 'Adicionei nova feature'`
4. Faça push: `git push origin minha-feature`
5. Abra um Pull Request
