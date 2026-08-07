package vn.iotstar.starshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import vn.iotstar.starshop.entity.Shipment;


public interface ShipmentRepository extends JpaRepository<Shipment, Integer> {
}