package DTOs;

import com.example.jooq.tables.TblCustomModifiers;
import com.example.jooq.tables.TblModifierValues;
import com.example.jooq.tables.records.TblCustomModifiersRecord;
import com.example.jooq.tables.records.TblModifierValuesRecord;

import java.util.List;

public class CustomCakeModifierDTO {
    private int modifierId;
    private String modifierName;
    private List<CustomModifierValueDTO> modifierList;

    public CustomCakeModifierDTO(int modifierId, String modifierName, List<CustomModifierValueDTO> modifierList) {
        this.modifierId = modifierId;
        this.modifierName = modifierName;
        this.modifierList = modifierList;
    }

    public CustomCakeModifierDTO(TblCustomModifiersRecord modifiersRecord, List<TblModifierValuesRecord> modifierValuesRecordList) {
        this.modifierId = modifiersRecord.getModifierId();
        this.modifierName = modifiersRecord.getModifierName();
        List<CustomModifierValueDTO> listOfModifierValues = null;
        for (TblModifierValuesRecord x : modifierValuesRecordList) {
            listOfModifierValues.add(new CustomModifierValueDTO(modifierId, x.getModifierValueId(), x.getModifierValue(), x.getPriceModifier()));
        }
        this.modifierList = listOfModifierValues;

    }

    public CustomCakeModifierDTO(TblCustomModifiersRecord modifiersRecord) {
        this.modifierId = modifiersRecord.getModifierId();
        this.modifierName = modifiersRecord.getModifierName();
    }

    public int getModifierId() {
        return modifierId;
    }

    public void setModifierId(int modifierId) {
        this.modifierId = modifierId;
    }

    public String getModifierName() {
        return modifierName;
    }

    public void setModifierName(String modifierName) {
        this.modifierName = modifierName;
    }

    public List<CustomModifierValueDTO> getModifierList() {
        return modifierList;
    }

    public void setModifierList(List<CustomModifierValueDTO> modifierList) {
        this.modifierList = modifierList;
    }
}