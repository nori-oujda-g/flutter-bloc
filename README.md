# crud by flutter bloc

In this link we will find an example of crud with a simple backend localhost based on bloc technology, and we have three examples: bloc consumer, bloc builder and bloc listener.
En Flutter, BLoC est un design pattern (modèle d’architecture) très utilisé pour gérer l’état d’une application de manière claire, structurée et réactive. Le mot BLoC signifie Business Logic Component.
## 🔍 Définition :
### BLoC est un modèle qui sépare :
La logique métier (Business Logic) : tout ce qui concerne les règles et traitements de l'application.
La présentation (UI) : ce que l’utilisateur voit et avec quoi il interagit.
### 🎯 Son rôle principal :
Le BLoC gère l'état de l'application en utilisant des flux de données (Streams en Dart). Il agit comme un intermédiaire entre l’interface utilisateur (UI) et les données.
### 🧱 Composants du pattern BLoC :
Events (Événements) : actions envoyées au BLoC, généralement à partir de l’interface utilisateur.
States (États) : résultats ou réponses du BLoC après traitement d’un événement.
Bloc : reçoit les événements, effectue des traitements, puis émet de nouveaux états.
UI : écoute les états via un BlocBuilder et se reconstruit automatiquement quand l’état change.
## différence entre bloc builder et bloc consumer et bloc listener en flutter :
En Flutter, quand on utilise le package **Bloc** (Business Logic Component), il existe plusieurs widgets pour interagir avec le `Bloc` : **BlocBuilder**, **BlocConsumer**, et **BlocListener**. Chacun a un rôle spécifique pour construire des interfaces réactives en fonction de l’état de l’application. Voici la différence entre ces trois :

---

### 1. **BlocBuilder**

🔹 **But** : Reconstruit l’interface utilisateur (UI) à chaque changement d’état.

🔹 **Utilisation** : Lorsque vous voulez mettre à jour l’UI en fonction de l’état actuel du `Bloc`.

🔹 **Signature** :

```dart
BlocBuilder<MyBloc, MyState>(
  builder: (context, state) {
    return Text('État: $state');
  },
)
```

🔹 **Ne fait pas** d’effets secondaires (comme navigation, snackbars, etc.)

---

### 2. **BlocListener**

🔹 **But** : Écoute les changements d’état **sans** reconstruire l’UI.

🔹 **Utilisation** : Pour exécuter des **effets secondaires**, comme montrer un `SnackBar`, naviguer à une nouvelle page, afficher une boîte de dialogue, etc.

🔹 **Signature** :

```dart
BlocListener<MyBloc, MyState>(
  listener: (context, state) {
    if (state is ErrorState) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erreur")));
    }
  },
  child: MyWidget(),
)
```

---

### 3. **BlocConsumer**

🔹 **But** : Combine **BlocBuilder** et **BlocListener**.

🔹 **Utilisation** : Lorsque vous voulez à la fois **mettre à jour l’UI** et **exécuter des effets secondaires** selon l’état.

🔹 **Signature** :

```dart
BlocConsumer<MyBloc, MyState>(
  listener: (context, state) {
    if (state is SuccessState) {
      Navigator.push(...);
    }
  },
  builder: (context, state) {
    return Text("État : $state");
  },
)
```

---

### Résumé comparatif :

| Widget       | Reconstruit l’UI | Effets secondaires | Utilisation principale                           |
| ------------ | ---------------- | ------------------ | ------------------------------------------------ |
| BlocBuilder  | ✅                | ❌                  | Afficher des données selon l’état                |
| BlocListener | ❌                | ✅                  | Réagir à un changement d’état sans modifier l’UI |
| BlocConsumer | ✅                | ✅                  | Combiner UI et logique de réaction               |

---

Si tu veux, je peux aussi te montrer un exemple complet en Flutter avec les trois dans un petit projet `Counter`.
