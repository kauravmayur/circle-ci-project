<aura:application extends="force:slds">
    <aura:handler name="init" value="{!this}" action="{!c.doInit}"/>
    <aura:attribute name="mylabel" type="string"/>
    <c:emPowerHeader/>
    <c:emPowerLoginHeader/>
    <c:emPowerBody/>
</aura:application>