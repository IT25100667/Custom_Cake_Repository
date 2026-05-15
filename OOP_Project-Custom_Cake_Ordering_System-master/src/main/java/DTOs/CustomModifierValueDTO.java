package DTOs;

import com.example.jooq.tables.TblModifierValues;
import com.example.jooq.tables.records.TblModifierValuesRecord;

public class CustomModifierValueDTO {
    private int modifierId;
    private int modifierValueId;
    private String modifierValue;
    private Double priceModifier;

    public CustomModifierValueDTO(int modifierId, Integer modifierValueId, String modifierValue, Double priceModifier) {
        this.modifierId = modifierId;
        this.modifierValueId = modifierValueId;
        this.modifierValue = modifierValue;
        this.priceModifier = priceModifier;
    }

    public CustomModifierValueDTO(TblModifierValuesRecord record){
        this.modifierId = record.getModifierId();
        this.modifierValueId = record.getModifierValueId();
        this.modifierValue = record.getModifierValue();
        this.priceModifier = record.getPriceModifier();
    }

    public int getModifierId() {
        return modifierId;
    }

    public void setModifierId(int modifierId) {
        this.modifierId = modifierId;
    }

    public int getModifierValueId() {
        return modifierValueId;
    }

    public void setModifierValueId(int modifierValueId) {
        this.modifierValueId = modifierValueId;
    }

    public String getModifierValue() {
        return modifierValue;
    }

    public void setModifierValue(String modifierValue) {
        this.modifierValue = modifierValue;
    }

    public Double getPriceModifier() {
        return priceModifier;
    }

    public void setPriceModifier(Double priceModifier) {
        this.priceModifier = priceModifier;
    }
}
