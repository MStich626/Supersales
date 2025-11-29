Projekt prezentuje analizę danych sprzedażowych i zwrotów produktów przy użyciu SQL. Głównym celem jest zidentyfikowanie:
* Top 3 produktów w każdej kategorii pod względem przychodu
* Najczęściej zwracanych produktów.


1. Best-selling products
Cel: Ustalić, które produkty generują największy przychód w ramach każdej kategorii.
Korzyści dla biznesu:
    * wspieranie decyzji o zapasach,
    * decyzje marketingowe (promocje na najpopularniejsze kategorie),
    * identyfikacja kluczowych produktów.

2. Most-returned products
Cel: Określić produkty najczęściej zwracane przez klientów.
Korzyści dla biznesu:
    * identyfikacja potencjalnych problemów jakościowych
    * poprawa opisu produktu
    * analiza rentowności

Użyte techniki SQL
* CTE (Common Table Expressions)
* Window functions (RANK() OVER (...))
* Agregacja i grupowanie (SUM, COUNT, GROUP BY)



# Supersales

Result first query:

| product_name | group | category | revenue | position | percentage |
|--------------|-------|----------|---------|----------|------------|
| HON-5400-Series-Task-Chairs-for-Big-and-Tall | Chairs | Furniture | 27338.22 | 1 | 3.02% |
| Riverside-Palais-Royal-Lawyers-Bookcase-Royale-Cherry-Finish | Bookcases | Furniture | 21143.52 | 2 | 2.33% |
| DMI-Eclipse-Executive-Suite-Bookcases | Bookcases | Furniture | 17884.86 | 3 | 1.97% |
| Fellowes-PB500-Electric-Punch-Plastic-Comb-Binding-Machine-with-Manual-Bind | Binders | Office Supplies | 39400.69 | 1 | 4.37% |
| GBC-DocuBind-P400-Electric-Binding-System | Binders | Office Supplies | 36746.73 | 2 | 4.08% |
| GBC-Ibimaster-500-Manual-ProClick-Binding-System | Binders | Office Supplies | 36527.04 | 3 | 4.05% |
| Canon-imageCLASS-2200-Advanced-Copier | Copiers | Technology | 69999.80 | 1 | 7.08% |
| Lexmark-MX611dhe-Monochrome-Laser-Printer | Machines | Technology | 27539.82 | 2 | 2.79% |
| Logitech-G19-Programmable-Gaming-Keyboard | Accessories | Technology | 25317.00 | 3 | 2.56% |
