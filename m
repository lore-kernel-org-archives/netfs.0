Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E534743F8B2
	for <netfs@lists.linux.dev>; Mon, 24 Aug 2026 15:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584171; cv=none; b=OAtd6KX2L+l10MgD7AxwrHQ02fZLSn1vBuvfGDnL9Bn8S4jMamMKPHY1p1uxPbC9/XyId1s64KpuugXgDdZVNMN1XIrtnhN5EgZ+ofVqKGfPBjhy7uAFmuCqWcN9138LagOfpJ2S8O1qnZVWI2M0P99tHIkdYrqVTqHe4mXjutI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584171; c=relaxed/simple;
	bh=jzysiI+Z7ED3gjpKEEkjgde2fjBamcXEnO22NlNgcsA=;
	h=From:To:cc:Subject:MIME-Version:Date:Message-ID:Content-Type; b=QeqXWMDiLF8/HmQNkKk72GWjtrjX0S+M+V0Azt9LsAVlLGF4QuV6UH7DAk0/+JXJ/I+Ael3bHRV0Ye1Wrxr63uCIktVEJ2r5rnwszRKXg50+GNNd344+OBLqs8Uz/YxNdsy4jUZPfqWFSvvRdgZRLeieFqaJG8R630r7Ne+VIPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qb1f5Bic; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qb1f5Bic"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787584168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R/czii9x+I9Y3WOKCsBlIX703Tg8UkuoKakbQTaHcYs=;
	b=Qb1f5Bicmfmg36W5Y5l1IKTbT102uPsoWa8wNdeCRkIMGt6nWUbAyh37+in0DwFItpXxi5
	HPDnPxQZvAn69RjGL//KTlfywLML+NM591ZyollgB1McBNSTTwOernGm0dduUndpLXw+5V
	aS5HGKO2dOK5XIBhajxK0MOsdzsKqYM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-jLeEkd0uMAu4nLGGWMEZWA-1; Mon,
 24 Aug 2026 11:09:24 -0400
X-MC-Unique: jLeEkd0uMAu4nLGGWMEZWA-1
X-Mimecast-MFC-AGG-ID: jLeEkd0uMAu4nLGGWMEZWA_1787584163
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 85A4F195FD2C;
	Mon, 24 Aug 2026 15:09:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.15])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4AAD71955F09;
	Mon, 24 Aug 2026 15:09:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    netfs@lists.linux.dev
Subject: Function to do end-writeback in bulk
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Mon, 24 Aug 2026 16:09:20 +0100
Message-ID: <761202.1787584160@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 512_dYKtztCs1nclyLb79qJo9Ho39pNGjEDGD-Aifns_1787584163
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <761201.1787584160.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

Hi Willy,

Can you take a look at the function below?  This is what I've come up with =
for
the moment for a basic bulk end-writeback (and I'll need something similar =
for
bulk unlock).  At the moment, it returns true/false depending on whether it
made progress, but I'm thinking that it might be better if it returns the
remaining size of any folio that partially overlaps the end position and so
didn't get unlocked.  This would could allow me to set a minimum amount to
accrue before I call it again.  Whether progress was made can also be
determined by comparing @from before and after.

Thanks,
David
---
/**
 * folio_end_writeback_range - End writeback for the folios within the rang=
e
 * @mapping: The pagecache to modify
 * @from: Pointer to the starting position (updated)
 * @to: The end position (exclusive)
 * @cleaner_func: Function to clean up the folios in the range
 * @cleaner_priv: Private data for the cleaner func
 *
 * Unlock folios that are entirely within in the given range, where @from i=
s
 * included in the range, but @to is excluded from the range.
 *
 * Return: True if at least one folio got cleaned, false otherwise.  @from =
will
 * be updated to point past the last folio cleaned.
 */
static inline
bool folio_end_writeback_range(struct address_space *mapping,
=09=09=09       uoff_t *from, uoff_t to,
=09=09=09       void (*cleaner_func)(struct folio *folio,
=09=09=09=09=09=09    void *cleaner_priv),
=09=09=09       void *cleaner_priv)
{
=09struct folio *folio;
=09XA_STATE(xas, &mapping->i_pages, *from / PAGE_SIZE);
=09bool cleaned =3D false;

=09rcu_read_lock();
=09xas_for_each(&xas, folio, (to - 1) / PAGE_SIZE) {
=09=09uoff_t fend;

=09=09if (xas_retry(&xas, folio))
=09=09=09continue;

=09=09fend =3D folio_next_pos(folio);
=09=09if (fend > to)
=09=09=09break;

=09=09cleaner_func(folio, cleaner_priv);
=09=09folio_end_writeback(folio);
=09=09*from =3D fend;
=09=09cleaned =3D true;
=09}
=09rcu_read_unlock();
=09return cleaned;
}

