# GroundTruth-Richtlinien für Arabisch
Der FID Nahost sieht zu Beginn der Arbeit an arabischer OCR eine Notwendigkeit zur Erstellung von GroundTruth-Richtlinien, da hier keine einheitlichen Regelungen auffindbar waren. Gleichzeitig ist die Nutzung einer einheitlichen GT als Grundlage für die Erstellung von Trainingsdaten unerlässlich, um eine Vergleichbarkeit und Nachnutzbarkeit zu sichern.
Als Grundlage für die Formulierung dieser Regeln wurde dabei die Transkription auf Basis der [OCR-D Richtlinien](https://ocr-d.de/gt//trans_documentation/index.html) angestrebt, die den Eigenheiten der arabischen Sprache angepasst wurde. Dabei wird ein besonderes Augenmerk auf den Umgang mit Ligaturen, Eulogien und der Nutzung von Vokalisierung gelegt.
Die arabische Schrift gehört zu den eher schwierigen Schriften für OCR und die Erstellung von GroundTruth. Dies liegt an der hohen Ähnlichkeit einiger Grundformen arabischer Buchstaben, die sich lediglich durch diakritische Punkte unterscheiden (was die Bedeutung qualitativ hochwertiger Scans in den Fokus rückt). Gleichzeitig erschwert die kursive Schrift die Erkennung von Buchstaben innerhalb eines Wortes, da die verbindenen Linien eine unterschiedliche Länge haben können, was zu Fehlinterpretationen führen kann. Entscheidend ist hier die Verwendung geeigneter Schrifttypen.

## Die Erstellung der GroundTruth
Ein zentral wichtiger Punkt bei der Erstellung trainierbarer Vorlagen ist eine exakte Übertragung der dargestellten Zeichen, es wird also keine Korrektur im Vergleich zum Druck vorgenommen. Die Daten werden im UTF-8 Format abgespeichert, um die Abbildbarkeit der Schriftzeichen sicherzustellen.

### Anlehnung an GroundTruth-Richtlinien von OCR-D
Hier wurde der Fokus auf [Level 2 der OCR-D Richtlinien](https://ocr-d.de/de/gt-guidelines/trans/level_2_2.html) gelegt und entsprechend der Besonderheiten der arabischen Schrift und dem arabischen Druckwesen angepasst:
* Drucktechnische Gegebenheiten des Originals werden soweit möglich wiedergegeben. Allerdings werden auch abhängig vom Druck grammatikalische Sachverhalte unterschiedlich dargestellt.
  * So wird bspw. das Tanwīn im Akkusativ mit der Nunation *-an* nach einschlägigen Grammatiklehrbüchern über dem Konsonanten gedruckt, in modernen Drucken hingegen befindet diese sich über dem Alif.
  * Die Ligatur *lām-alif* (ursprünglich ist der linke Schaft das lām und der rechte alif, so dass bei Dopplung des lām das šadda auf dem linken Schaft liegen sollte. In der modernen Orthographie ist dies weitgehend hinfällig, wird aber teilweise doch noch dargestellt.
* Die Interpretation von Zeichen orientiert sich an ihrem Gebrauch im Sprach- und Schriftsystem.
* Ligaturen werden in ihre Einzelbuchstaben aufgespalten. Ausnahme bilden besondere Ligaturen wie الله, die automatisch generiert werden und nicht aufgebrochen werden können.
* Leerzeichen werden ausschließlich zur Trennung von Wörtern verwendet.
* Satzzeichen werden als eigene Einheit erfasst. Die Fehlerquote bei der Anbindung an das vorhergehende Wort ist recht hoch, da z.B. Kommata dann häufig als Hamza interpretiert werden, was den Wortsinn verfälschen kann.
* Allgemein gilt: Sind Unicode-Zeichen vorhanden, sollten diese zur Darstellung verwendet werden.

### Zahlen, Klammern und Schmuckelemente
Die Darstellung von Zahlen, Klammern und Schmuckelemente erwies sich als problematisch, da hier verschiedene Faktoren aufeinander treffen:
* Hochgestellte Zahlen und Klammern sind bei sehr kleinem Druck schlecht von Vokalisierungszeichen unterscheidbar.
  * Für die Erfassung und zur Unterscheidung werden sie in den Fließtext aufgenommen, dies verringert aber ggf. die Erkennungsrate.
* Zahlen tauchen sowohl als arabische wie auch als indische Zahlen auf und werden entsprechend der Vorlagenform erfasst - dadurch verdoppelt sich aber die Menge der Zahlzeichen.
* Klammern werden als solche erfasst, Schmuckklammern werden gesondert aufgenommen, da es hierfür ein eigenes Unicode-Zeichen gibt.

## Modelltraining
### Workflow
* Bildbearbeitung mit Gimp (Binarisierung, Bildausrichtung)
* Erstellung der ALTO-Dateien mithilfe von [Tesseract](https://github.com/tesseract-ocr/tesseract)
* Nachkorrektur der ALTO-Daten in [Transkribus](https://transkribus.eu/) und Erzeugung von Daten im PAGE-XML-Format, die für das Modelltraining benutzt werden können.
* automatisierte Erzeugung von zeilenweisen Bildern und Texten für das Training
  * hierfür werden in Transkribus auch die Zeilen- und Wortboxen nachkorrigiert, so dass ein automatisches Schneiden möglichtst wenig Fehler produziert
  * Problem beim Erstellen des Textes: Transkribus ordnet die *Reading Order* immer von links nach rechts. Damit sind für linksläufige Schriften die Wörter spiegelverkehrt angeordnet. Bevor ein Training erfolgen kann, muss die Reading Order also angepasst werden.
* Die Erkennungsrate von Buchstaben ist in Tesseract bereits mit vorhandenen Modellen recht gut (auf Basis von Texten aus dem 20. Jh.). Vokalisierungen, Satzzeichen und Zahlen werden hingegen nur schlecht erkannt, wodurch die Gesamtgenauigkeit sinkt.
  * Kommata werden häufig als Hamzas erkannt, ebenso wie Klammern.
  * Da es sich bei Arabisch um eine Konsonantenschrift handelt, kann eine fehlerhaft interpretierte Vokalisation, wenn vorhanden, zu einer falschen Lesart führen und dadurch den Textsinn verfälschen (z.B. aktiv/passiv).
  * Eine falsche Darstellung von Zahlen führt zu Problemen bei der Zuordnung von Fußnoten und Anmerkungen.
* Um diese Erkennung gezielt zu trainieren werden diese Zeichen daher zunächst vollständig als eigene Entität erfasst.
  * Fragestellung: Kann durch die exakte Transkription einzelner Zeichen die automatische Erkennung verbessert werden?
