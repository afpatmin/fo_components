<h1>FoComponents 0.0.1</h1>
<h2>fo-icon</h2>
<h4>Description</h4>
<p>SVG icon</p>
<h4>Attributes</h4>
<ul>
    <li>foSrc: Which icon id from within [icons.svg]</li>
    <li>foTitle: Icon title and aria-label 
</ul>
<h4>Example</h4>
<code>&lt;fo-icon foSrc="coins" foTitle="Coins"&gt;&lt;/fo-icon&gt;</code>

<h2>fo-popup</h2>
<h4>Description</h4> 
<p>A popup dialog with a title and text content covering the window.</p>
<h4>Attributes</h4>
<ul>
    <li>foText: Text content</li>
    <li>foTitle: Header title</li>
</ul>
<h4>Example</h4>
<code>&lt;fo-popup foText="Something went wrong!" foTitle="Alert"&gt;&lt;/fo-popup&gt;</code>
<h4>Remarks</h4>
<p>No more than one popup window can be open at a time</p>