Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02694320A04
	for <netfs@lists.linux.dev>; Thu, 26 Mar 2026 22:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563512; cv=none; b=eGJA79GACKYFYis1x/nidYClg1AAmH9+3/gl6XYDM/1xxGXB8NZbQ6KfPqpXQGSZ6GiFK124Gv6OwgTk6R4bXpZrVXGe5/fpL3ug/U85quGgnydEXxgLKcwdyyvUbgquCajX0e6zRkQxJ2L9xJjtuDKc1UTBR4EFPjN6v87vxfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563512; c=relaxed/simple;
	bh=PWuYZAnrBMRw0qrud2r6VCR5KugEVJe+PHQAHSx11C4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=Zuml2XrDhsbSbSkT3g7+C5PTjbbVeWvBO2OULMCgSCbm8N4EUPuL5ZUF5aEvoKtxn1k5uKuj8DHOhX4nuuMRz3S0CQ9WFU586TIR9CAEHU98JYMWRRVuhlthZl0Aw6Wue0lTZi0jmQFXHhYTEkd6pvOb6AqfEaQp8V4j1trn3UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=l+39p9gV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M8FrwB6c; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="l+39p9gV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M8FrwB6c"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 4837AEC0190;
	Thu, 26 Mar 2026 18:18:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 26 Mar 2026 18:18:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:reply-to:subject:subject:to:to; s=fm1; t=1774563508; x=
	1774649908; bh=nB7g6qG78sUaPlTd7dQL/ByixpSwJ6KwpsjjzdKk0Mc=; b=l
	+39p9gVgTNGQiTsFQiZIt4gpXDA9oQhUtYggSRZLg7zun1Ku7Dt02FUV7lYV1Kqn
	QUUAtqMw8bs3xJpDE6PV6tdnA+7hxz5pH5xmIaGDCyjQv1bwzi95+NCbF1ghjwSC
	YplnFLaMBJYYTeVaabbTU6evZsYJ53z7tZZdz9ctICkQemfYGq03/ZQfLLIW4JSe
	VeVTxHxSYyAqfavwD+rsNLsLanRFJ+KZUa07Y6hzwqcilpGRwQBUrGUUGeGxA9xF
	lg3dmpYUZyP4X+/ofkciusQXEqntQn836g/ZSon+xzM1KlY6IAeiY0uW2Plr+CJC
	ED6v0xicqFD8vALZLGovw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
	:subject:subject:to:to:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1774563508; x=1774649908; bh=nB7g6qG78sUaP
	lTd7dQL/ByixpSwJ6KwpsjjzdKk0Mc=; b=M8FrwB6cj9aAX6UV90MQsneQM0w+8
	DGB3JH2TKol6QFpnfFGFHMgvGABEBg2qSD4xZlGwf4Ol7e5znNs2W1EdjNTTo0ML
	o+vdro8l83NOzd5eAYecNUgV/KsXaAfWnjzCGG4xzPyPf15krUqVOlFYjNIrnSTG
	4z9cvb8/yJ908OxgawLE5m4ut6Cuo13iQZ8rM7spMqmcMAXEKbF0hJ0/tPCu8QJI
	httJwFu+h+hEtSFAz5GJ52FKhaaOqMLOLLgYN1hfLMcvLfKLICh2Hna1lFaJRnLG
	0FMgp2j3QzGCA0UwAVb9+pcbihjNpRt8PUS0FuAEDI2midukbLf2hztSg==
X-ME-Sender: <xms:tLDFaV2sH_HexHfvfNtYSdxftxigPh1TWa6OtALOoli3bACBcFweSQ>
    <xme:tLDFaerRx90AXbj7_UhKjNDM0f1j5eLsLZFdw-e-bRnF6VjinWM-VAIRUZU8FIwAn
    ncjyc2l_vzdk8O3NDBBxDeN0htP1Oei98PXd-ScsqXmmZDKtlM>
X-ME-Received: <xmr:tLDFaZhxguvqmPjeUIjhlMte0U-QOsygGVtvJRRLXIucb3utjEGrJFLJwEiPvq7PZz3XnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdekheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheurhho
    fihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepff
    ehfeettedtieetuedtgeevfffhffdtheelleffffeujedvleevgfdvgfelleeunecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsgesoh
    ifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopeguhhhofigvlhhlshesrhgvughhrghtrdgtohhmpdhrtghpth
    htohepphgtsehmrghnghhuvggsihhtrdhorhhgpdhrtghpthhtohepnhgvthhfsheslhhi
    shhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdgrfhhssehlihhsth
    hsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepmhgrrhgtrdguihhonhhnvgesrghurhhishhtohhrrd
    gtohhm
X-ME-Proxy: <xmx:tLDFaS-jRQ78I1CCin8uAm3lyYuh-03rulDTKKVKBz9CqIV89QYK0w>
    <xmx:tLDFadXkFleNBN2pb0y1H4yQ4qvDHIMwQ9_Bdc1pz035hMzeyLslCw>
    <xmx:tLDFaeCCVGKPn5JJ0CE6ces8hD8KohZkN7xabxAKk9a5zj_VdsaNNg>
    <xmx:tLDFaaH1F3sOCZq9Jnqwg6pA2bawF46UFkzayyU6uitIKxhtYEYTpg>
    <xmx:tLDFaQF6ui4W8wMN3bYfssitUK0GSJuVtpZr926-e_slL_XNo47tTT_Y>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 18:18:25 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To:
 Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>
Cc: Marc Dionne <marc.dionne@auristor.com>, Paulo Alcantara <pc@manguebit.org>,
 netfs@lists.linux.dev, linux-afs@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 [PATCH] cachefiles: fix incorrect dentry refcount in cachefiles_cull()
Date: Fri, 27 Mar 2026 09:18:21 +1100
Message-id: <177456350181.1851489.16359967086642190170@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>


The patch mentioned below changed cachefiles_bury_object() to expect 2
references to the 'rep' dentry.  Three of the callers were changed to
use start_removing_dentry() which takes an extra reference so in those
cases the call gets the expected references.

However there is another call to cachefiles_bury_object() in
cachefiles_cull() which did not need to be changed to use
start_removing_dentry() and so was not properly considered.
It still passed the dentry with just one reference so the net result is
that a reference is lost.

To meet the expectations of cachefiles_bury_object(), cachefiles_cull()
must take an extra reference before the call.  It will be dropped by
cachefiles_bury_object().

Reported-by: Marc Dionne <marc.dionne@auristor.com>
Fixes: 7bb1eb45e43c ("VFS: introduce start_removing_dentry()")
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/cachefiles/namei.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index b498c210112b..1b83ed0e0a63 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -781,6 +781,11 @@ int cachefiles_cull(struct cachefiles_cache *cache, stru=
ct dentry *dir,
 	if (ret < 0)
 		goto error_unlock;
=20
+	/*
+	 * cachefiles_bury_object() expects 2 references to 'victim',
+	 * and drops one.
+	 */
+	dget(victim);
 	ret =3D cachefiles_bury_object(cache, NULL, dir, victim,
 				     FSCACHE_OBJECT_WAS_CULLED);
 	dput(victim);

base-commit: 84f524dca4b8bc9e9aca8ea1dbbd2aa3a239d998
--=20
2.50.0.107.gf914562f5916.dirty

