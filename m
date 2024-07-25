Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FD61F17B
	for <netfs@lists.linux.dev>; Thu, 25 Jul 2024 22:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721944965; cv=none; b=SwvpQ3T+yGluxUfR2lZto031PovZ1pCmkYTEzA7pqKaAUIyy6JC+oXajz3QgtBuz6p0wizH5OECvAN0zxaaRoGbQkvj4SoUS/K+CkY/9yiCZkr9xXs/CmH4hOO2JwfyQcZvOrum7R27KRE1pFapaer2cuAGIGrLeqVIV46arwjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721944965; c=relaxed/simple;
	bh=RdhYrF47gl93YNRu+47Uqwxo1c4co2U6ihvG3DGhLM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KlhlcXz96yrUVbT1lqRl0feN6JTU9FGtd3HiCNLWXUaS5Kb+DnwJELIhdRwrbrHI1YE3HYOuuySAm2+Z9qCtvbT1fptbSa2RDGzMnik0shTwbMWtM/dJFaBJ+kJX72z3OiK7i9SY2QCErNtOh0/2XnztuSL8gH8Pkt9WYhHbPm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H7d4ydoz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H7d4ydoz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=jX0zXVXbovdEngmQrfxgWGePu4+ciky2sHO6Y73yTaI=; b=H7d4ydozf18jUX6dEUK7MUEdur
	JRkkT3rSnwdqgeWUs9zHYGhM7Gc5b16HqrRc98uq8+bKhFE0RS9E4AZGkr339xzs1N9Df3bS/rYCn
	rcipnfbkV7yoWclxlZCOtG5M7yaIDMOs9Vka4saQmeLdsvHueVIu/oewmIcu2mL79+3rvExkkGb4x
	NnkcPAp/d/Be79mHSmUEL2HDfwwfTqrDl9N3HIeI5vbrbjBp5+mvdRXOxpwT6wgB4n0IA8BAihkAb
	2OVlkxrgyfMUWBNwSd2GpRXo+f/CVU2lrtEK+Vipzt9p+Hf2COYBwdlCXSAmzPxh0+86RngPtYRR6
	E73+G0fw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sX6Xo-00000009Qc3-3LGj;
	Thu, 25 Jul 2024 22:02:40 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	netfs@lists.linux.dev
Subject: [PATCH 1/2] netfs: Remove call to folio_index()
Date: Thu, 25 Jul 2024 23:02:36 +0100
Message-ID: <20240725220239.2247246-1-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling folio_index() is pointless overhead; directly dereferencing
folio->index is fine.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/trace/events/netfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index da23484268df..5f199e01e888 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -420,7 +420,7 @@ TRACE_EVENT(netfs_folio,
 	    TP_fast_assign(
 		    __entry->ino = folio->mapping->host->i_ino;
 		    __entry->why = why;
-		    __entry->index = folio_index(folio);
+		    __entry->index = folio->index;
 		    __entry->nr = folio_nr_pages(folio);
 			   ),
 
-- 
2.43.0

