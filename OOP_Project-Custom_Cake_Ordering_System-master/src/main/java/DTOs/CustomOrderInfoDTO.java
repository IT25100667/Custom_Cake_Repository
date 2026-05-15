package DTOs;

import com.example.jooq.tables.TblCustomOrderInfo;
import com.example.jooq.tables.records.TblCustomOrderInfoRecord;
import com.example.jooq.tables.records.TblShoppingCartItemsRecord;

import java.text.NumberFormat;

public class CustomOrderInfoDTO {
    public int id;
    public int order_id;
    public int modifier_id;
    public int modifierValueId;
    public String chosenText;

    public CustomOrderInfoDTO(int order_id, int modifier_id, int modifierValueId, String chosenText) {
        this.order_id = order_id;
        this.modifier_id = modifier_id;
        this.modifierValueId = modifierValueId;
        this.chosenText = chosenText;
    }

    public CustomOrderInfoDTO(int id, int order_id, int modifier_id, int modifierValueId, String chosenText) {
        this.id = id;
        this.order_id = order_id;
        this.modifier_id = modifier_id;
        this.modifierValueId = modifierValueId;
        this.chosenText = chosenText;
    }

    public CustomOrderInfoDTO(TblCustomOrderInfoRecord tblCustomOrderInfoRecord) {
        if(tblCustomOrderInfoRecord.getCustomOrderId()!=null){
            this.id = tblCustomOrderInfoRecord.getCustomOrderId();
            this.order_id = tblCustomOrderInfoRecord.getOrderId();
            this.modifier_id = tblCustomOrderInfoRecord.getModifierId();
            this.modifierValueId = tblCustomOrderInfoRecord.getModifierValueId();
            this.chosenText = tblCustomOrderInfoRecord.getChosenText();
        }
    }

    public TblCustomOrderInfoRecord getRecord(){
        return getRecord(false);
    }

    public TblCustomOrderInfoRecord getRecord(boolean includeId){
        TblCustomOrderInfoRecord customOrderInfo = new TblCustomOrderInfoRecord();
        if(includeId) customOrderInfo.setCustomOrderId(id);
        customOrderInfo.setOrderId(order_id);
        customOrderInfo.setModifierId(modifier_id);
        customOrderInfo.setModifierValueId(modifierValueId);
        customOrderInfo.setChosenText(chosenText);
        return customOrderInfo;
    }
}
