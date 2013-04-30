<?xml version="1.0" encoding="utf-8"?>
<rules>
    <rule>
        <whitelist>admin:main\.login,admin:main\.doLogin,admin:product\.uploadProductImage</whitelist>
        <securelist>^admin</securelist>
        <roles>admin</roles>
        <permissions>read,write</permissions>
        <redirect>admin:main\.login</redirect>
    </rule>
</rules>