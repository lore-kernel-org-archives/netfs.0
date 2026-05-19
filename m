Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F143FE648
	for <netfs@lists.linux.dev>; Tue, 19 May 2026 10:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779186184; cv=none; b=jy+DgsI7VLn7XYmeMZZJDv8WCCUYASZqdO2QNNQCT9SESODue3LQ9DO6P5MpkvBIQpT9XgldYMjymp71oeWrUmS1ABuNZsyyvSWUE8SBOzWCmvyRfCjfPfBGzDReFnGcPIiLvt+QvNfC8LfFjrwm9jDpxdmeTh3327cryMI5hJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779186184; c=relaxed/simple;
	bh=dOt7tvoRaTPjVMCowEPEy627fiSaBdDeltsTvaQzODU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=BSY74iNe2QIUS3gbooZMez+dBagvygLgqkW4muwPHAUrpZB0EMIpb9cVmc8EINxp069ZY3GS9SxDt0luvdwqSCFGqygTLb9f2B6MRCI3XaWi4jVjaV5r5f4LthaiJ/OkreToySxkkUEfXsZ20mOZdfKoVK9jxvpX1TbAecHP6Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HkYIlwN5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HkYIlwN5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779186182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FHv0wA8qYdfuCzR7/8BZb1BosqZySnrazKlwIjeZxDg=;
	b=HkYIlwN5Cxxs+NynNUAqqpORT1bEEkzaahEX9Ne1j528k4wdyhvKbWH0jdL33J+Zcyw9Al
	4A6+ulMpooiplcsxi5n7GamCLLAJmxXPheypV1BRCPICkdP8D1Sr0I+oqBn6ArccePF4H4
	GaHHEFlp1n/4p+BF39geU20fb5QmiOw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-Lt3Qo-O-Odi2YXiWNN1wKA-1; Tue,
 19 May 2026 06:22:56 -0400
X-MC-Unique: Lt3Qo-O-Odi2YXiWNN1wKA-1
X-Mimecast-MFC-AGG-ID: Lt3Qo-O-Odi2YXiWNN1wKA_1779186175
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA465195605C;
	Tue, 19 May 2026 10:22:54 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.33])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C01B61956053;
	Tue, 19 May 2026 10:22:51 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Stefan Metzmacher <metze@samba.org>,
	Mina Almasry <almasrymina@google.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 10/36] cifs: Split crypt_message() into encrypt and decrypt variants
Date: Tue, 19 May 2026 11:21:28 +0100
Message-ID: <20260519102158.592165-11-dhowells@redhat.com>
In-Reply-To: <20260519102158.592165-1-dhowells@redhat.com>
References: <20260519102158.592165-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: 0oOWj2eF9dEyoPcnpAOphrhleYp1TmgwAbe_8Y073_k_1779186175
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Split crypt_message() into encrypt and decrypt variants so that the encrypt
variant can be substantially changed.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/smb2ops.c | 103 +++++++++++++++++++++++++++++++++-------
 1 file changed, 87 insertions(+), 16 deletions(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index f39074d0e4a0..10bb0fe6b77b 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -4458,16 +4458,17 @@ smb2_get_enc_key(struct TCP_Server_Info *server, __u64 ses_id, int enc, u8 *key)
 
 	return -EAGAIN;
 }
+
 /*
- * Encrypt or decrypt @rqst message. @rqst[0] has the following format:
+ * Encrypt @rqst message. @rqst[0] has the following format:
  * iov[0]   - transform header (associate data),
  * iov[1-N] - SMB2 header and pages - data to encrypt.
  * On success return encrypted data in iov[1-N] and pages, leave iov[0]
  * untouched.
  */
 static int
-crypt_message(struct TCP_Server_Info *server, int num_rqst,
-	      struct smb_rqst *rqst, int enc, struct crypto_aead *tfm)
+encrypt_message(struct TCP_Server_Info *server, int num_rqst,
+		struct smb_rqst *rqst, struct crypto_aead *tfm)
 {
 	struct smb2_transform_hdr *tr_hdr =
 		(struct smb2_transform_hdr *)rqst[0].rq_iov[0].iov_base;
@@ -4482,10 +4483,10 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
 	unsigned int crypt_len = le32_to_cpu(tr_hdr->OriginalMessageSize);
 	void *creq;
 
-	rc = smb2_get_enc_key(server, le64_to_cpu(tr_hdr->SessionId), enc, key);
+	rc = smb2_get_enc_key(server, le64_to_cpu(tr_hdr->SessionId), 1, key);
 	if (rc) {
-		cifs_server_dbg(FYI, "%s: Could not get %scryption key. sid: 0x%llx\n", __func__,
-			 enc ? "en" : "de", le64_to_cpu(tr_hdr->SessionId));
+		cifs_server_dbg(FYI, "%s: Could not get encryption key. sid: 0x%llx\n",
+				__func__, le64_to_cpu(tr_hdr->SessionId));
 		return rc;
 	}
 
@@ -4510,11 +4511,6 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
 	if (IS_ERR(creq))
 		return PTR_ERR(creq);
 
-	if (!enc) {
-		memcpy(sign, &tr_hdr->Signature, SMB2_SIGNATURE_SIZE);
-		crypt_len += SMB2_SIGNATURE_SIZE;
-	}
-
 	if ((server->cipher_type == SMB2_ENCRYPTION_AES128_GCM) ||
 	    (server->cipher_type == SMB2_ENCRYPTION_AES256_GCM))
 		memcpy(iv, (char *)tr_hdr->Nonce, SMB3_AES_GCM_NONCE);
@@ -4530,16 +4526,91 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
 	aead_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
 				  crypto_req_done, &wait);
 
-	rc = crypto_wait_req(enc ? crypto_aead_encrypt(req)
-				: crypto_aead_decrypt(req), &wait);
+	rc = crypto_wait_req(crypto_aead_encrypt(req), &wait);
 
-	if (!rc && enc)
+	if (!rc)
 		memcpy(&tr_hdr->Signature, sign, SMB2_SIGNATURE_SIZE);
 
 	kfree_sensitive(creq);
 	return rc;
 }
 
+/*
+ * Decrypt @rqst message. @rqst[0] has the following format:
+ * iov[0]   - transform header (associate data),
+ * iov[1-N] - SMB2 header and pages - data to decrypt.
+ * On success return encrypted data in iov[1-N] and pages, leave iov[0]
+ * untouched.
+ */
+static int
+decrypt_message(struct TCP_Server_Info *server, int num_rqst,
+		struct smb_rqst *rqst, struct crypto_aead *tfm)
+{
+	struct smb2_transform_hdr *tr_hdr =
+		(struct smb2_transform_hdr *)rqst[0].rq_iov[0].iov_base;
+	unsigned int assoc_data_len = sizeof(struct smb2_transform_hdr) - 20;
+	int rc = 0;
+	struct scatterlist *sg;
+	u8 sign[SMB2_SIGNATURE_SIZE] = {};
+	u8 key[SMB3_ENC_DEC_KEY_SIZE];
+	struct aead_request *req;
+	u8 *iv;
+	DECLARE_CRYPTO_WAIT(wait);
+	unsigned int crypt_len = le32_to_cpu(tr_hdr->OriginalMessageSize);
+	void *creq;
+
+	rc = smb2_get_enc_key(server, le64_to_cpu(tr_hdr->SessionId), 0, key);
+	if (rc) {
+		cifs_server_dbg(FYI, "%s: Could not get decryption key. sid: 0x%llx\n",
+				__func__, le64_to_cpu(tr_hdr->SessionId));
+		return rc;
+	}
+
+	if ((server->cipher_type == SMB2_ENCRYPTION_AES256_CCM) ||
+		(server->cipher_type == SMB2_ENCRYPTION_AES256_GCM))
+		rc = crypto_aead_setkey(tfm, key, SMB3_GCM256_CRYPTKEY_SIZE);
+	else
+		rc = crypto_aead_setkey(tfm, key, SMB3_GCM128_CRYPTKEY_SIZE);
+
+	if (rc) {
+		cifs_server_dbg(VFS, "%s: Failed to set aead key %d\n", __func__, rc);
+		return rc;
+	}
+
+	rc = crypto_aead_setauthsize(tfm, SMB2_SIGNATURE_SIZE);
+	if (rc) {
+		cifs_server_dbg(VFS, "%s: Failed to set authsize %d\n", __func__, rc);
+		return rc;
+	}
+
+	creq = smb2_get_aead_req(tfm, rqst, num_rqst, sign, &iv, &req, &sg);
+	if (IS_ERR(creq))
+		return PTR_ERR(creq);
+
+	memcpy(sign, &tr_hdr->Signature, SMB2_SIGNATURE_SIZE);
+	crypt_len += SMB2_SIGNATURE_SIZE;
+
+	if ((server->cipher_type == SMB2_ENCRYPTION_AES128_GCM) ||
+	    (server->cipher_type == SMB2_ENCRYPTION_AES256_GCM))
+		memcpy(iv, (char *)tr_hdr->Nonce, SMB3_AES_GCM_NONCE);
+	else {
+		iv[0] = 3;
+		memcpy(iv + 1, (char *)tr_hdr->Nonce, SMB3_AES_CCM_NONCE);
+	}
+
+	aead_request_set_tfm(req, tfm);
+	aead_request_set_crypt(req, sg, sg, crypt_len, iv);
+	aead_request_set_ad(req, assoc_data_len);
+
+	aead_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
+				  crypto_req_done, &wait);
+
+	rc = crypto_wait_req(crypto_aead_decrypt(req), &wait);
+
+	kfree_sensitive(creq);
+	return rc;
+}
+
 /*
  * Copy data from an iterator to the pages in a bvec queue buffer.
  */
@@ -4618,7 +4689,7 @@ smb3_init_transform_rq(struct TCP_Server_Info *server, int num_rqst,
 	/* fill the 1st iov with a transform header */
 	fill_transform_hdr(tr_hdr, orig_len, old_rq, server->cipher_type);
 
-	rc = crypt_message(server, num_rqst, new_rq, 1, server->secmech.enc);
+	rc = encrypt_message(server, num_rqst, new_rq, server->secmech.enc);
 	cifs_dbg(FYI, "Encrypt message returned %d\n", rc);
 	if (rc)
 		goto err_free;
@@ -4680,7 +4751,7 @@ decrypt_raw_data(struct TCP_Server_Info *server, char *buf,
 		tfm = server->secmech.dec;
 	}
 
-	rc = crypt_message(server, 1, &rqst, 0, tfm);
+	rc = decrypt_message(server, 1, &rqst, tfm);
 	cifs_dbg(FYI, "Decrypt message returned %d\n", rc);
 
 	if (is_offloaded)

