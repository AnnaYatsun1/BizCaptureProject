# BizCaptureProject

BizCaptur is a lightweight logistics CRM/operations app for iPad and iPhone, featuring voice input, barcode scanning, smart data entry, and offline mode.
Below is a detailed breakdown of what the app does, its data model, architecture, and MVP roadmap.

 Inventory

Create or edit items manually or by voice, scan barcodes/QR codes, attach photos, and add custom attributes.

Operations

Receipt — registering incoming goods

Transfer — moving stock between warehouses or locations

Issue / Shipment — sending goods out

Search & Filters

Full-text and voice-based search by SKU, name, serial number, brand, status, or location.
📊 Movement History

View all stock movements for each item or warehouse.

Export & Sharing

Export documents and reports as PDF, CSV, or JSON, and share via email or integrations.

Offline-First

All actions work offline and sync automatically when the device reconnects.

Roles & Permissions

Two base roles:

Operator — performs warehouse operations

Manager — reviews, approves, and manages permissions
Module	Purpose
CoreSPM	Shared models, protocols, DI (swift-dependencies), logging, and error handling
NetworkingKit	API client (URLSession, async/await, JWT auth, retries)
PersistenceKit	Local storage (SwiftData on iOS 17+ or GRDB fallback)
FeatureHome	Dashboard: quick actions and recent operations
FeatureInventory	Item list, detail, create/edit screens
FeatureScan	Camera integration (VisionKit/AVFoundation) + barcode/QR recognition
FeatureMove / FeatureReceipt / FeatureIssue	Operational flows with form entry and document printing
FeatureSearch	Global search (text + voice)
FeatureVoice	Voice commands (Whisper / Speech framework) and conversational layer
FeatureSettings	Warehouses, users, API keys, access rights
