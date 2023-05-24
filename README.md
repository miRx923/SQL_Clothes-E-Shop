# Oracle SQL Clothes E-Shop
School assignment about implementing an Oracle SQL database. 

# How to create foreign key constraints using ChatGPT (model used GPT-3.5-turbo)
<b>Note: May not work for you.</b>

&emsp;&emsp;Foreign key constraints in this project were created by "one-shot chain-of-thought" prompting technique using ChatGPT. I wanted to share the prompt with you. You could try it if you needed to.

<b>ChatGPT prompt:</b>
```
You are an Oracle SQL Database Developer and also an Entity Relationship Diagram (ERD) creator and Relationship Diagram (RD) creator. You are really good at it. Your field of specialisation is a Clothes E-Shop databases which you are really good at. I will explain you what entities I have in my ERD, what Attributes they have, which are Primary Keys (PK). In exchange you will tell me how should my Relationship Diagram be interconnected, so what are foreign keys to what primary keys. Don't forget to think slowly in steps so everything would be done correctly. The structure of your answears will have following structure:

{Name of the table (Name of the entity in ERD)}:
{Attribute which is Primary Key (PK)} -> {Attribute which will be the Foreign Key (FK) for the Primary Key(PK)}

If you understood what I request from you, just type "UNDERSTOOD".
```

<i>Wait for it's answear.</i>

```
So, we will start, I will copy paste you Oracle SQL code for creating tables and attributes in my database and YOU WILL TELL ME IF IT IS CORRECT. Remember, think about it slowly. Write only "UNDERSTOOD" if you understood.
```

<i>Wait for it's answear.</i>

<i>Now paste your code for creating tables.</i>

```
So now that you have the code and understand what Entities and their attributes are there. Try to tell me how to interconnect the entities. Here is structure that you will follow:

{Entity} | {Attribute that is Primary Key (PK)} <-> {Entity} | {Attribute that will be the Foreign Key (FK)}

Type "UNDERSTOOD" if you understood.
```

That should output something looking like this:

"Understood. Here are the relationships between the entities:

<b>
review | review_id <-> product | product_id<br>
review | review_id <-> customer | customer_id<br>
customer_address | customer_id <-> customer | customer_id<br>
order_info | order_id <-> customer | customer_id<br>
order_history | order_id <-> order_info | order_id<br>
order_history | payment_method <-> payment | payment_method<br>
payment | payment_id <-> order_info | order_id<br>
product | product_id <-> category | category_id<br>
</b>
<br>
  
Please let me know if you have any questions or need any clarification."

## Filling the tables
&emsp;&emsp; <b>Note:</b> You can also ask for guidance in which order to fill in tables.
  
# Entity Relationship  Diagram
Here you can see the Entity Relationship Diagram of the database:

![--> There should be Entity Relationship Diagram <--](/diagrams/ERD%20-%20Clothes-E-Shop.png)


# Relationship  Diagram
Here you can see the Relationship Diagram of the database:

![--> There should be Relationship Diagram <--](/diagrams/RD%20-%20Clothes-E-Shop.png)
