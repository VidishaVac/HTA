## Copilot prompts are vital to your output

### Best practices

Adding Copilot as a pair programmer to your RStudio is simple, and has a seamless interface. Take a look at Posit's documentation [here](https://docs.posit.co/ide/user/ide/guide/tools/copilot.html).

### Better prompting

🚧 Prompting Pitfalls: What You Ask Is What You Get

As someone who’s long relied on the wonderful Stack Overflow for both writing and debugging code (and still do), I’ve recently begun experimenting with GitHub Copilot inside RStudio. (Posit PBC GitHub)

It’s powerful and easy to use, but effective prompting often requires fine-tuning.

Here’s a real example from my work with the diabetes dataset from the UCI ML repo:

📂 The data includes 23 medication types, each categorized into one of four levels: 𝘕𝘰, 𝘚𝘵𝘦𝘢𝘥𝘺, 𝘜𝘱, or 𝘋𝘰𝘸𝘯.
📊 After visualizing all 23 meds using a bar plot, I wanted to explore alternate plot types that could reveal more nuanced insights. I turned to Copilot for help — but what followed was a great lesson in the importance of specificity. 👇
🖼️ In the image below, you can follow my conversation with Copilot: 
I began with a vague prompt (“Can you fix this blank plot?”) 
Then refined it a little (“Can you use a different kind of plot?”) 
Finally, I gave it the specific guidance it needed (which variables to use and how to specify its aesthetics)

🔍 Only when I provided clear, well-scoped instructions did Copilot return a useful, meaningful visualization.

💡 Takeaway: The quality of your output depends on the quality of your prompt. Copilot is powerful, but only if you guide it with precision.

![alt text](convo.png)


