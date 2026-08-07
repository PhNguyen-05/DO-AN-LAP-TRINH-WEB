package vn.iotstar.starshop.entity;

import jakarta.persistence.*;
import lombok.*;

import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Embeddable
public class WishlistId implements Serializable {
    private Integer userId;
    private Integer productId;
}
